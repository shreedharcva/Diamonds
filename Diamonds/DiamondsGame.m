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
    
    Sprite* grid;
    Sprite* background;
    
    Sprite* sprite;
}

- (void) loadResources: (ResourceManager*) resources
{        
    background = [[Sprite alloc] initWithTexture: [resources loadTexture: @"back000"]];
    grid = [[Sprite alloc] initWithTexture: [resources loadTexture: @"grid"]];
    
    sprite = [[Sprite alloc] initWithTexture: [resources loadTexture: @"ruby"]];
    
    [background moveTo: CGPointMake(0, 0)];
    [grid moveTo: CGPointMake(0, 0)];
    
    [sprite moveTo: CGPointMake(200, 0)];

    [sprite setSourceRectangle: CGRectMake(0, 0, 32, 32)];
    [sprite resizeTo: CGSizeMake(32, 32)];
}

- (void) update: (GameTime*) gameTime
{
    float speed = 0.0;
    if (sprite.position.y + sprite.size.height < self.engine.windowSize.height)
    {
        speed = [gameTime elapsedTimeInMilliseconds] * 0.1;
    }
    
    [sprite moveBy: CGVectorMake(0, speed)];
    
    NSLog(@"game time = %2.1f height = %2.1f", [gameTime elapsedTimeInMilliseconds], sprite.position.y); 
}

- (void) draw: (GameTime*) gameTime
{    
    batch = [[SpriteBatch alloc] initWithEngine: self.engine];
    
    [batch begin];
    
    [background drawIn: batch];
    [grid drawIn: batch];
    [sprite drawIn: batch];
    
    [batch end];
}

@end
