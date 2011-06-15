//
//  ShaderProgram.h
//  Diamonds

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

@class Texture;

@interface ShaderProgram : NSObject 

- (void) load;
- (bool) validate;

- (void) use;

- (void) setParameter: (int) uniform with1f: (float) value;
- (void) setParameter: (int) uniform withTextureObject: (Texture*) texture;

@end
