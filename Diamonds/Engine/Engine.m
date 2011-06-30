//
//  Engine.m
//  Diamonds

#import "Engine.h"
#import "Texture.h"
#import "ShaderProgram.h"
#import "Sprite.h"

#import "EAGLView.h"

#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


@interface Engine ()
{    
    EAGLView* view;    
    EAGLContext *glcontext;
    
    Sprite* sprite1;
    Sprite* sprite2;
}

@end


@implementation Engine

- (id) initWithView: (EAGLView*) glview
{
    self = [super init];
    if (self == nil)
        return nil;

    view = glview;    
    
    int w = [[UIScreen mainScreen] currentMode].size.width;
    if (w == 640)
    {
        view.contentScaleFactor = 2.0f;
    }
    
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!aContext)
    {
        NSLog(@"Failed to create ES context");
        return nil;
    }
    if (![EAGLContext setCurrentContext:aContext])
    {
        NSLog(@"Failed to set ES context current");
        return nil;
    }
    
	glcontext = aContext;
    
    [view setContext: glcontext];
    [view setFramebuffer];
    
    sprite1 = [Sprite new];
    sprite2 = [Sprite new];
    
    [sprite1 moveTo: CGPointMake(0, 0)];
    [sprite2 moveTo: CGPointMake(200, 0)];
       
    return self;
}

- (void) dealloc
{ 
    if ([EAGLContext currentContext] == glcontext)
    {
        [EAGLContext setCurrentContext: nil];
    }    
}

- (int) contentScale
{
    int w = [[UIScreen mainScreen] currentMode].size.width;
    if (w == 320)
        return 2.0;
    else
        return 1.0;
}

- (CGSize) windowSize
{
    GLfloat viewport[4];
    glGetFloatv(GL_VIEWPORT, viewport);
    
    CGSize size;    
    size.width = (float) viewport[2] * self.contentScale;
    size.height = (float) viewport[3] * self.contentScale;
    
    return size;
}

- (void) beginFrame
{
    [view setFramebuffer];
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
}

- (void) endFrame
{
    [view presentFramebuffer];
}

- (void) drawFrame
{
    [self beginFrame];
    [sprite1 drawUsingEngine: self];
    [sprite2 drawUsingEngine: self];
    [self endFrame];   
}

@end

