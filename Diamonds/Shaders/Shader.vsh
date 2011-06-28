//
//  Shader.vsh
//  Diamonds

attribute vec4 position;
attribute vec2 texcoord; 

varying vec2 texcoordVarying;

uniform mat4  modelViewProjectionMatrix;

void main()
{
    gl_Position = position;
    gl_Position *= modelViewProjectionMatrix;
    
    texcoordVarying = texcoord;
}
