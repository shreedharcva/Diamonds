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
    
    Sprite* sprite;
}

@end


@implementation Engine

- (id) initWithView: (EAGLView*) glview
{
    self = [super init];
    if (self == nil)
        return nil;

    view = glview;    
    
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
    
    sprite = [Sprite new];
       
    return self;
}

- (void) dealloc
{ 
    if ([EAGLContext currentContext] == glcontext)
        [EAGLContext setCurrentContext:nil];
    
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
 
    [sprite draw];

    [self endFrame];   
}


@end
