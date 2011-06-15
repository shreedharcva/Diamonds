//
//  Engine.h
//  Diamonds


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@class EAGLView;
@class ShaderProgram;

@interface Engine : NSObject 
{
    EAGLView* view;

    EAGLContext *glcontext;
    GLuint texture;
    
    ShaderProgram* shaderProgram;
}

@property (retain, nonatomic) EAGLView* view;

@property (assign, nonatomic) EAGLContext* glcontext;
@property (assign, nonatomic) GLuint texture;

- (id) initWithView: (EAGLView*) glview;

- (void) loadShaders;
- (void) loadTextures;

- (void) drawFrame;

@end
