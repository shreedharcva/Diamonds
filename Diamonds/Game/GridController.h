//
//  GridController.h
//  Diamonds

@class Grid;
@class DroppablePair;

@interface GridController : NSObject
{
}

@property (readonly) DroppablePair* droppablePair;

- (id) initWithGrid: (Grid*) grid;

- (void) setGravity: (float) newGravity;
- (void) setDroppingGravity: (float) droppingGravity;

- (void) spawn;

- (void) moveRight;
- (void) moveLeft;

- (void) rotateLeft;
- (void) rotateRight;

- (void) drop;

- (void) update;

@property (readonly, nonatomic) Grid* grid;

@end
