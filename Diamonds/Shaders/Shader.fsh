//
//  Shader.fsh
//  Diamonds

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
