// based on https://godotshaders.com/shader/film-grain-shader/
#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float time;
    float grain_amount;
    float grain_size;
    bool animate;
};
layout(binding = 1) uniform mediump sampler2D source;
layout(location = 0) out vec4 fragColor;

void main(void)
{
    vec4 tex = texture(source, qt_TexCoord0);
    vec2 uv = qt_TexCoord0;
    float noise = 0.0;
    if (animate) {
        noise = fract(sin(dot(uv * time, vec2(12.9898, 78.233))) * 43758.5453);
    } else {
        noise = fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
    }
    tex.rgb += noise * grain_amount * grain_size;
    fragColor = tex;

}



