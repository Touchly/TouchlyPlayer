#version 310 es
precision mediump float;

uniform vec4 uColor;

layout(location = 0) in vec2 vTex;
layout(binding = 0) uniform sampler2D uTex;
layout(location = 0) out vec4 FragColor;

void main()
{
    FragColor = uColor * texture(uTex, vTex);
}

