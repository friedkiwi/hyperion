
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
All such modifications placed in the public domain by Stephen R. Orso
Modifications:
 1) Changed value returned on negative non-zero input from max uint-64 to
    zero.  (Figure 19-19 on page 19-26 of SA22-7832-10.)
=============================================================================*/


#ifdef HAVE_PLATFORM_H 
#include "platform.h" 
#endif
#if !defined(false) 
#include <stdbool.h> 
#endif
#if !defined(int32_t) 
#include <stdint.h>             /* C99 standard integers */ 
#endif
#include "internals.h"
#include "softfloat.h"

uint_fast64_t f64_to_ui64( float64_t a, uint_fast8_t roundingMode, bool exact )
{
    union ui64_f64 uA;
    uint_fast64_t uiA;
    bool sign;
    int_fast16_t exp;
    uint_fast64_t sig;
    int_fast16_t shiftCount;
#ifdef SOFTFLOAT_FAST_INT64
    struct uint64_extra sigExtra;
#else
    uint32_t extSig[3];
#endif

    uA.f = a;
    uiA = uA.ui;
    sign = signF64UI( uiA );
    exp  = expF64UI( uiA );
    sig  = fracF64UI( uiA );
    if ( exp ) sig |= UINT64_C( 0x0010000000000000 );
    shiftCount = 0x433 - exp;
#ifdef SOFTFLOAT_FAST_INT64
    if ( shiftCount <= 0 ) {
        if ( shiftCount < -11 ) {
            softfloat_raiseFlags( softfloat_flag_invalid );
#ifdef IBM_IEEE
            return sign ? UINT64_C(0) : UINT64_C(0xFFFFFFFFFFFFFFFF);
#else
            return UINT64_C(0xFFFFFFFFFFFFFFFF);
#endif /* IBM_IEEE  */
        }
        sigExtra.v = sig<<-shiftCount;
        sigExtra.extra = 0;
    } else {
        sigExtra = softfloat_shiftRightJam64Extra( sig, 0, shiftCount );
    }
    return
        softfloat_roundPackToUI64(
            sign, sigExtra.v, sigExtra.extra, roundingMode, exact );
#else
    extSig[indexWord( 3, 0 )] = 0;
    if ( shiftCount <= 0 ) {
        if ( shiftCount < -11 ) {
            softfloat_raiseFlags( softfloat_flag_invalid );
#ifdef IBM_IEEE
            return UINT64_C(0);
#else
            return UINT64_C(0xFFFFFFFFFFFFFFFF);
#endif /* IBM_IEEE  */
        }
        sig <<= -shiftCount;
        extSig[indexWord( 3, 2 )] = sig>>32;
        extSig[indexWord( 3, 1 )] = sig;
    } else {
        extSig[indexWord( 3, 2 )] = sig>>32;
        extSig[indexWord( 3, 1 )] = sig;
        softfloat_shiftRightJam96M( extSig, shiftCount, extSig );
    }
    return softfloat_roundPackMToUI64( sign, extSig, roundingMode, exact );
#endif

}

