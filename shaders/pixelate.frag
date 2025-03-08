// based on https://godotshaders.com/shader/film-grain-shader/
#version 450

layout(location = 0) in vec2 qt_TexCoord0;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 textureResolution;
    float pixelSize;
};
layout(binding = 1) uniform mediump sampler2D source;
layout(location = 0) out vec4 fragColor;

void main(void)
{
    vec4 tex = texture(source, qt_TexCoord0);
    vec2 uv = qt_TexCoord0;

    vec4 pixelatedTex = tex;
    vec2 uvPixelated = (floor(uv * textureResolution / pixelSize) + 0.5) * pixelSize / textureResolution;
    pixelatedTex = texture(source, uvPixelated);

    fragColor = mix(tex, pixelatedTex, qt_Opacity);
}
