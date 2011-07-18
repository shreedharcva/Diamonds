//
//  GridController.h
//  Diamonds

@class Grid;
@class DroppablePair;

@interface GridController : NSObject
{
    DroppablePair* droppablePair;
}

- (id) initWithGrid: (Grid*) grid;

- (void) setGravity: (float) newGravity;

- (void) spawn;
- (DroppablePair*) droppablePair;

- (void) moveRight;
- (void) moveLeft;
- (void) update;

@property (readonly, nonatomic) Grid* grid;

@end
