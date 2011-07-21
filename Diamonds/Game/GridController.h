//
//  GridController.h
//  Diamonds

@class Grid;
@class DroppablePair;

@interface GridController : NSObject
{
    DroppablePair* droppablePair;
}

@property (readonly) DroppablePair* droppablePair;

- (id) initWithGrid: (Grid*) grid;

- (void) setGravity: (float) newGravity;

- (void) spawn;

- (void) moveRight;
- (void) moveLeft;

- (void) rotateLeft;
- (void) rotateRight;

- (void) update;

@property (readonly, nonatomic) Grid* grid;

@end
