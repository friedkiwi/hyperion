
/*============================================================================

This C source file is part of the SoftFloat IEEE Floating-Point Arithmetic
Package, Release 3a, by John R. Hauser.

Copyright 2011, 2012, 2013, 2014 The Regents of the University of California.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice,
    this list of conditions, and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions, and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

 3. Neither the name of the University nor the names of its contributors may
    be used to endorse or promote products derived from this software without
    specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS", AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE
DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=============================================================================*/

/*============================================================================
Modifications to comply with IBM IEEE Binary Floating Point, as defined
in the z/Architecture Principles of Operation, SA22-7832-10, by
Stephen R. Orso.  Said modifications identified by compilation conditioned
on preprocessor variable IBM_IEEE.
All such modifications placed in the public domain by Stephen R. Orso.
Modifications:
1) Changed processing such that softfloat_flag_tiny is raised when input
exponents are both zero and the result significand is not zero.  This
can occur when adding a tiny to zero or another tiny.
=============================================================================*/

#include "platform.h" 
#include "internals.h"

#if  1  /* includes define for IBM_IEEE  */
#include "softfloat.h"
#endif /* IBM_IEEE */

#include "specialize.h"

float64_t
 softfloat_addMagsF64( uint_fast64_t uiA, uint_fast64_t uiB, bool signZ )
{
    int_fast16_t expA;
    uint_fast64_t sigA;
    int_fast16_t expB;
    uint_fast64_t sigB;
    int_fast16_t expDiff;
    uint_fast64_t uiZ;
    int_fast16_t expZ;
    uint_fast64_t sigZ;
    union ui64_f64 uZ;

    expA = expF64UI( uiA );
    sigA = fracF64UI( uiA );
    expB = expF64UI( uiB );
    sigB = fracF64UI( uiB );
    expDiff = expA - expB;
    sigA <<= 9;
    sigB <<= 9;
    if ( ! expDiff ) {
        if ( expA == 0x7FF ) {
            if ( sigA | sigB ) goto propagateNaN;
            uiZ = uiA;
            goto uiZ;
        }
#ifdef IBM_IEEE
        if ( ! expA ) {
            sigZ = (uiA + uiB) & UINT64_C(0x7FFFFFFFFFFFFFFF);          /* Sum the significands and exclude sign bits       */
            if (!(sigZ & 0XFFF0000000000000) && sigZ) {                 /* if exp zero and sig non-zero, then subnormal     */
                softfloat_raw.Incre = false;                             /* Result was not incremented                       */
                softfloat_raw.Inexact = false;                           /* Result is not inexact                            */
                softfloat_raw.Sig64 = sigZ << 10;                        /* 32 + 7; save rounded significand for scaling     */
                softfloat_raw.Sig0 = 0;                                  /* Zero bits 64-128 of rounded result               */
                softfloat_raw.Exp = -1022;                               /* Save semi-unbiased exponent                      */
                softfloat_raw.Sign = signZ;                              /* Save result sign                                 */
                softfloat_raw.Tiny = true;                               /* Indicate a subnormal result                      */
                softfloat_exceptionFlags |= softfloat_flag_tiny;        /* nonzero result is tiny                           */
            }
            uiZ = packToF64UI(signZ, 0, sigZ);                          /* Pack up a zero or a subnormal                    */
            goto uiZ;
        }
#else   
        if ( ! expA ) {
            uiZ =
                packToF64UI(
                    signZ, 0, (uiA + uiB) & UINT64_C( 0x7FFFFFFFFFFFFFFF ) );
            goto uiZ;
        }
#endif /* IBM_IEEE */
        expZ = expA;
        sigZ = UINT64_C( 0x4000000000000000 ) + sigA + sigB;
    } else {
        if ( expDiff < 0 ) {
            if ( expB == 0x7FF ) {
                if ( sigB ) goto propagateNaN;
                uiZ = packToF64UI( signZ, 0x7FF, 0 );
                goto uiZ;
            }
            expZ = expB;
            sigA += expA ? UINT64_C( 0x2000000000000000 ) : sigA;
            sigA = softfloat_shiftRightJam64( sigA, -expDiff );
        } else {
            if ( expA == 0x7FF ) {
                if ( sigA ) goto propagateNaN;
                uiZ = uiA;
                goto uiZ;
            }
            expZ = expA;
            sigB += expB ? UINT64_C( 0x2000000000000000 ) : sigB;
            sigB = softfloat_shiftRightJam64( sigB, expDiff );
        }
        sigZ = UINT64_C( 0x2000000000000000 ) + sigA + sigB;
        if ( sigZ < UINT64_C( 0x4000000000000000 ) ) {
            --expZ;
            sigZ <<= 1;
        }
    }
    return softfloat_roundPackToF64( signZ, expZ, sigZ );
 propagateNaN:
    uiZ = softfloat_propagateNaNF64UI( uiA, uiB );
 uiZ:
    uZ.ui = uiZ;
    return uZ.f;

}
