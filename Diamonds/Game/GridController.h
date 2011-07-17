//
//  GridController.h
//  Diamonds

@class Grid;
@class Droppable;
@class Gem;

@interface GridController : NSObject
{
    Droppable* droppablePair;
}

- (id) initWithGrid: (Grid*) grid;

- (void) setGravity: (float) newGravity;

- (void) spawn;
- (Droppable*) droppablePair;

- (void) moveRight;
- (void) moveLeft;
- (void) update;

@property (readonly, nonatomic) Grid* grid;

@end
