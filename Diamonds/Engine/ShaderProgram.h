//
//  ShaderProgram.h
//  Diamonds


#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

enum 
{
    UNIFORM_TRANSLATE,
    UNIFORM_TEXTURE,
    NUM_UNIFORMS
};

enum 
{
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    ATTRIB_TEXCOORD,
    NUM_ATTRIBUTES
};

extern GLint uniforms[NUM_UNIFORMS];

@interface ShaderProgram : NSObject 
{
    GLuint program;
    GLint uniforms[NUM_UNIFORMS];
}

- (void) load;
- (bool) validate;

- (void) use;

- (void) setParamter: (int) uniform with1f: (float) value;
- (void) setParamter: (int) uniform withTexture: (int) texture;


@end
