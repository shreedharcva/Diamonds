//
//  Sprite.m
//  Diamonds

#import "SpriteBatch.h"

#import "Sprite.h"
#import "ShaderProgram.h"
#import "Texture.h"
#import "Engine.h"

#import <QuartzCore/QuartzCore.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <GLKit/GLKMath.h>

@implementation SpriteBatch
{
    Engine* engine;
}

- (id) initWithEngine: (Engine*) theEngine
{
    self = [super init];
    if (self == nil)
        return nil;
    
    engine = theEngine;
    
    return self;    
}

- (Engine*) engine
{
    return engine;
}

- (bool) isEmpty
{
    return YES;
}

- (void) begin
{
}

- (void) end
{
}

- (void) drawQuad: (CGPoint) position size: (CGSize) size;
{
}

@end