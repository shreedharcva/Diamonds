//
//  DiamondsGame.m
//  Diamonds

#import "DiamondsGame.h"

#import "Engine.h"
#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"

#import "Grid.h"
#import "Gem.h"

@implementation DiamondsGame
{
    SpriteBatch* batch;
    
    Sprite* gridSprite;
    Sprite* background;
        
    Grid* grid;
    GridDrawer* gridDrawer;
}

- (void) loadResources: (ResourceManager*) resources
{        
    background = [[Sprite alloc] initWithTexture: [resources loadTexture: @"back000"]];
    gridSprite = [[Sprite alloc] initWithTexture: [resources loadTexture: @"grid"]];
        
    [background moveTo: CGPointMake(0, 0)];
    [gridSprite moveTo: CGPointMake(0, 0)];
        
    GridPresentationInfo info;
    
    info.origin = CGPointMake(0, 0);
    info.cellSize = CGSizeMake(32, 32);
    
    grid = [[Grid alloc] initWithResources: resources];
    gridDrawer = [[GridDrawer alloc] initWithGrid: grid info: info];
    
    [grid put: Ruby at: MakePosition(0, 0)];
    [grid put: Diamond at: MakePosition(1, 0)];
}

- (void) update: (GameTime*) gameTime
{
    NSLog(@"game time = %2.1f", [gameTime elapsedTimeInMilliseconds]); 
}

- (void) draw: (GameTime*) gameTime
{    
    batch = [[SpriteBatch alloc] initWithEngine: self.engine];
    
    [batch begin];
    
    [background drawIn: batch];
    [gridSprite drawIn: batch];
    [gridDrawer drawIn: batch];
    
    [batch end];
}

@end
