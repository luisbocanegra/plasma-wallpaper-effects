// based on Qt5Compat.GraphicalEffects.OpacityMask but does the opposite
#version 450

layout(location = 0) in vec2 qt_TexCoord0;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
};
layout(binding = 1) uniform mediump sampler2D source;
layout(binding = 2) uniform mediump sampler2D maskSource;
layout(location = 0) out vec4 fragColor;

void main(void)
{
    fragColor = texture(source, qt_TexCoord0.st) * (1 - texture(maskSource, qt_TexCoord0.st).a) * qt_Opacity;
}
