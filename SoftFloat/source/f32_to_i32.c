
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

#include "platform.h" 
#include "internals.h"
#include "softfloat.h"

int_fast32_t f32_to_i32( float32_t a, uint_fast8_t roundingMode, bool exact )
{
    union ui32_f32 uA;
    uint_fast32_t uiA;
    bool sign;
    int_fast16_t exp;
    uint_fast32_t sig;
    uint_fast64_t sig64;
    int_fast16_t shiftCount;

    uA.f = a;
    uiA = uA.ui;
    sign = signF32UI( uiA );                /* Separate components of float32                   */
    exp  = expF32UI( uiA );
    sig  = fracF32UI( uiA );
    if ( (exp == 0xFF) && sig ) sign = 0;   /* If infinity, set positive sign                   */
    if ( exp ) sig |= 0x00800000;           /* If not tiny, make implicit units digit explicit  */
    sig64 = (uint_fast64_t) sig<<32;        /* Move significand to high word of uint-64         */
    shiftCount = 0xAF - exp;
    if ( 0 < shiftCount ) {
        sig64 = softfloat_shiftRightJam64( sig64, shiftCount );
    }
    return softfloat_roundPackToI32( sign, sig64, roundingMode, exact );

}
