//
//  Shader.fsh
//  Diamonds

varying mediump vec2 texcoordVarying;

uniform sampler2D texture;

void main()
{
    gl_FragColor = texture2D(texture, texcoordVarying);
}
