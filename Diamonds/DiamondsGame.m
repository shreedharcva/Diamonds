//
//  DiamondsGame.m
//  Diamonds

#import "DiamondsGame.h"

#import "Engine.h"
#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"

#import "Grid.h"
#import "GridController.h"
#import "Gem.h"

@implementation DiamondsGame
{
    SpriteBatch* batch;
    
    Sprite* background;
        
    Grid* grid;
    GridDrawer* gridDrawer;
    GridController* gridController;
    
    float nextUpdateTime;
}

- (void) moveLeft
{
    [gridController moveLeft];
}

- (void) moveRight
{
    [gridController moveRight];
}

- (void) loadResources: (ResourceManager*) resources
{        
    background = [[Sprite alloc] initWithTexture: [resources loadTexture: @"back000"]];
        
    [background moveTo: CGPointMake(0, 0)];
        
    GridPresentationInfo info;
    
    info.origin = CGPointMake(20, 32);
    info.cellSize = CGSizeMake(32, 32);
    info.heightInCells = 14;
    
    grid = [[Grid alloc] initWithResources: resources width: 8 height: 14];

    
    gridDrawer = [[GridDrawer alloc] initWithGrid: grid info: info];

    Sprite* gridBackground = [[Sprite alloc] initWithTexture: [resources loadTexture: @"grid"]];

    [gridBackground resizeTo: CGSizeMake(256, 512)];
    [gridBackground setSourceRectangle: CGRectMake(0, 0, 256, 512)];
    
    [gridDrawer setBackground: gridBackground];
    
    gridController = [[GridController alloc] initWithGrid: grid];

    [gridController setGravity: 0.05];
    [gridController spawn];
        
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
        [gridController update];
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
