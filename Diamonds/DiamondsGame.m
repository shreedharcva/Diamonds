//
//  DiamondsGame.m
//  Diamonds

#import "DiamondsGame.h"

#import "Engine.h"
#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"

@implementation DiamondsGame
{
    SpriteBatch* batch;
    
    Sprite* sprite1;
    Sprite* sprite2;
}

- (void) loadResources: (ResourceManager*) resources
{        
    sprite1 = [[Sprite alloc] initWithTexture: [resources loadTexture: @"diamond"]];
    sprite2 = [[Sprite alloc] initWithTexture: [resources loadTexture: @"ruby"]];
    
    [sprite1 moveTo: CGPointMake(0, 0)];
    [sprite2 moveTo: CGPointMake(200, 0)];

    [sprite2 setSourceRectangle: CGRectMake(0, 0, 32, 32)];
    [sprite2 resizeTo: CGSizeMake(32, 32)];
}

- (void) update: (GameTime*) gameTime
{
    static float y = 0.0;
    if (y + sprite2.size.height < self.engine.windowSize.height)
    {
        y += [gameTime elapsedTimeInMilliseconds] * 0.1;
    }
    [sprite2 moveTo: CGPointMake(200, y)];
}

- (void) draw: (GameTime*) gameTime
{    
    batch = [[SpriteBatch alloc] initWithEngine: self.engine];
    
    [batch begin];
    
    [sprite1 drawIn: batch];
    [sprite2 drawIn: batch];
    
    [batch end];
}

@end
