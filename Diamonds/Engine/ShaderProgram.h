//
//  ShaderProgram.h
//  Diamonds

enum 
{
    UNIFORM_MODEL_VIEW_PROJECTION_MATRIX,
    UNIFORM_TRANSLATE,
    UNIFORM_TEXTURE,
    NUM_UNIFORMS
};

enum 
{
    ATTRIB_VERTEX,
    ATTRIB_TEXCOORD,
    NUM_ATTRIBUTES
};

@class Texture;

@interface ShaderProgram : NSObject 

- (void) load;
- (bool) validate;

- (void) use;

- (void) setParameter: (int) uniform withMatrix4f: (float*) matrix;
- (void) setParameter: (int) uniform with1f: (float) value;
- (void) setParameter: (int) uniform withTextureObject: (Texture*) texture;

@end
