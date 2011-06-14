//
//  Shader.fsh
//  Diamonds

varying lowp vec4 colorVarying;
varying mediump vec2 texcoordVarying;

uniform sampler2D texture;

void main()
{
//    highp vec4 color = textur2D(
//    gl_FragColor = colorVarying;

//    gl_FragColor.xy = texcoordVarying;    
//    gl_FragColor.zw = vec2(0.0, 0.0);
  
    gl_FragColor = texture2D(texture, texcoordVarying);

}
