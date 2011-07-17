//
//  GridController.h
//  Diamonds

@class Grid;
@class Droppable;
@class Gem;

@interface GridController : NSObject
{
    Droppable* controlledGem;
}

- (id) initWithGrid: (Grid*) grid;

- (void) setGravity: (float) newGravity;

- (void) spawn;
- (Gem*) controlledGem;

- (void) moveRight;
- (void) moveLeft;
- (void) update;

@property (readonly, nonatomic) Grid* grid;

@end
