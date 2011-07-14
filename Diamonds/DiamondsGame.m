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
    
    Sprite* background;
        
    Grid* grid;
    GridDrawer* gridDrawer;
    
    float nextUpdateTime;
}

- (void) loadResources: (ResourceManager*) resources
{        
    background = [[Sprite alloc] initWithTexture: [resources loadTexture: @"back000"]];
        
    [background moveTo: CGPointMake(0, 0)];
        
    GridPresentationInfo info;
    
    info.origin = CGPointMake(20, 32);
    info.cellSize = CGSizeMake(32, 32);
    info.heightInCells = 14;
    
    grid = [[Grid alloc] initWithResources: resources];

    
    gridDrawer = [[GridDrawer alloc] initWithGrid: grid info: info];

    Sprite* gridBackground = [[Sprite alloc] initWithTexture: [resources loadTexture: @"grid"]];

    [gridBackground resizeTo: CGSizeMake(256, 512)];
    [gridBackground setSourceRectangle: CGRectMake(0, 0, 256, 512)];
    
    [gridDrawer setBackground: gridBackground];

    [grid put: Ruby at: MakePosition(0, 10)];
    
    nextUpdateTime = 0.0f;
}

- (void) update: (GameTime*) gameTime
{
//    NSLog(@"game time = %2.1f", [gameTime elapsedTimeInMilliseconds]); 

    if (nextUpdateTime == 0.0f)
    {
        nextUpdateTime = [gameTime milliseconds];
    }
    
    if ([gameTime milliseconds] >= nextUpdateTime)
    {
        static int turn = 0;
        turn++;
        int turns = 100;
        if (turn % turns == 0 && turn / turns < 5)
        {
            [grid put: Ruby at: MakePosition(turn / turns + 1, 10)];
        }
        [grid updateWithGravity: 0.05f];        
    }    
}

- (void) draw: (GameTime*) gameTime
{ 
    batch = [[SpriteBatch alloc] initWithEngine: self.engine];
    
    [batch begin];
    
    [background drawIn: batch];
    [gridDrawer drawBackgroundIn: batch];
    [gridDrawer drawIn: batch];
    
    [batch end];
}

@end
