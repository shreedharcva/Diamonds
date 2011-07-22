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

- (id) initWithGrid: (Grid*) grid_ at: (GridCell) cell_ with: (GemType[]) gems resources: (ResourceManager*) resources;

- (void) rotateLeft;
- (void) rotateRight;

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end