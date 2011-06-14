//
//  Shader.vsh
//  Diamonds

attribute vec4 position;
attribute vec4 color;
attribute vec2 texcoord; 

varying vec4 colorVarying;
varying vec2 texcoordVarying;

uniform float translate;

void main()
{
    gl_Position = position;
//    gl_Position.y += sin(translate) / 2.0;

    colorVarying = color;
    texcoordVarying = texcoord;
}
