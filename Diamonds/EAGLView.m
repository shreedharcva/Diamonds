//
//  EAGLView.m
//  OpenGLES_iPhone

#import <QuartzCore/QuartzCore.h>
#import <GLKit/GLKMath.h>

#import "EAGLView.h"

@interface EAGLView (PrivateMethods)

- (void) createFramebuffer;
- (void) deleteFramebuffer;

@end

@implementation EAGLView

@synthesize context;

+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
	if (self) 
    {
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking,
                                        kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat,
                                        nil];
    }
    
    return self;
}

- (void) dealloc
{
    [self deleteFramebuffer];    
    
}

- (void) setContext:(EAGLContext *)newContext
{
    if (context != newContext) 
    {
        [self deleteFramebuffer];
        
        context = newContext;
        
        [EAGLContext setCurrentContext:nil];
    }
}

- (void) createFramebuffer
{
    if (context && !defaultFramebuffer) 
    {
        [EAGLContext setCurrentContext:context];
        
        // Create default framebuffer object.
        glGenFramebuffers(1, &defaultFramebuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
        
        // Create color render buffer and allocate backing store.
        glGenRenderbuffers(1, &colorRenderbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
        [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer];
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &framebufferWidth);
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &framebufferHeight);
        
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
        
        if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
            NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    }
}

- (void) deleteFramebuffer
{
    if (context)
    {
        [EAGLContext setCurrentContext:context];
        
        if (defaultFramebuffer) 
        {
            glDeleteFramebuffers(1, &defaultFramebuffer);
            defaultFramebuffer = 0;
        }
        
        if (colorRenderbuffer) {
            glDeleteRenderbuffers(1, &colorRenderbuffer);
            colorRenderbuffer = 0;
        }
    }
}

- (void) setFramebuffer
{
    if (!context) 
        return;

    [EAGLContext setCurrentContext:context];
    
    if (!defaultFramebuffer)
    {
        [self createFramebuffer];
    }
    
    
    glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
    
    glViewport(0, 0, framebufferWidth, framebufferHeight);
}

- (void) createResources
{
}

- (BOOL) presentFramebuffer
{
    if (!context) 
        return false;
    
    [EAGLContext setCurrentContext:context];
    
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    
    return [context presentRenderbuffer:GL_RENDERBUFFER];
 }

- (void) layoutSubviews
{
    [self deleteFramebuffer];
}

@end
