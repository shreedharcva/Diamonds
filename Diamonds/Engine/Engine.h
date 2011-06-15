//
//  Engine.h
//  Diamonds


#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@class EAGLView;

@interface Engine : NSObject 
{
    EAGLView* view;

    EAGLContext *glcontext;
    GLuint program;
    GLuint texture;
}

@property (retain, nonatomic) EAGLView* view;

@property (assign, nonatomic) EAGLContext* glcontext;
@property (assign, nonatomic) GLuint program;
@property (assign, nonatomic) GLuint texture;

- (id) initWithView: (EAGLView*) glview;

- (void) loadShaders;
- (void) loadTextures;

- (BOOL) compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL) linkProgram:(GLuint)prog;
- (BOOL) validateProgram:(GLuint)prog;

- (void) drawFrame;

@end
