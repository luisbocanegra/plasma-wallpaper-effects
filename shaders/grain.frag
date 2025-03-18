// based on https://godotshaders.com/shader/film-grain-shader/
#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float time;
    float grain_amount;
    bool animate;
};
layout(binding = 1) uniform mediump sampler2D source;
layout(location = 0) out vec4 fragColor;

///// Random / noise functions for GLSL https://stackoverflow.com/a/17479300
uint hash( uint x ) {
    x += ( x << 10u );
    x ^= ( x >>  6u );
    x += ( x <<  3u );
    x ^= ( x >> 11u );
    x += ( x << 15u );
    return x;
}

uint hash( uvec2 v ) { return hash( v.x ^ hash(v.y)                         ); }
// Construct a float with half-open range [0:1] using low 23 bits.
// All zeroes yields 0.0, all ones yields the next smallest representable value below 1.0.
float floatConstruct( uint m ) {
    const uint ieeeMantissa = 0x007FFFFFu; // binary32 mantissa bitmask
    const uint ieeeOne      = 0x3F800000u; // 1.0 in IEEE binary32

    m &= ieeeMantissa;                     // Keep only mantissa bits (fractional part)
    m |= ieeeOne;                          // Add fractional part to 1.0

    float  f = uintBitsToFloat( m );       // Range [1:2]
    return f - 1.0;                        // Range [0:1]
}

// Pseudo-random value in half-open range [0:1].
float random( vec2  v ) { return floatConstruct(hash(floatBitsToUint(v))); }
///// Random / noise functions for GLSL

void main(void)
{
    vec4 tex = texture(source, qt_TexCoord0);
    vec2 uv = qt_TexCoord0;
    float noise = 0.0;
    if (animate) {
        noise = random(qt_TexCoord0 + time);
    } else {
        noise = random(qt_TexCoord0);
    }
    tex.rgb += noise * grain_amount;
    fragColor = tex;
}
