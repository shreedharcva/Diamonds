//
//  DroppablePair.h
//  Diamonds

#import "Gem.h"
#import "GemAggregate.h"

typedef enum PairOrientation 
{
    VerticalUp      = 0,
    HorizontalLeft  = 1,
    VerticalDown    = 2,
    HorizontalRight = 3,
}
PairOrientation;

@interface DroppablePair : GemAggregate 

@property (readonly) PairOrientation orientation;

@property (readonly) Gem* pivot;
@property (readonly) Gem* buddy;

+ (void) setDroppingGravity: (float) droppingGravity_;

- (id) initWithGrid: (Grid*) grid_ at: (GridCell) cell_ with: (GemType[]) gems;

- (void) rotateLeft;
- (void) rotateRight;

- (void) drop;
- (bool) isDropping;

@end