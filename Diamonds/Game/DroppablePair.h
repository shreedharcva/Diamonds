//
//  DroppablePair.h
//  Diamonds

#import "Gem.h"
#import "GemAggregate.h"

typedef enum DroppablePairOrientation 
{
    VerticalUp = 0,
    HorizontalLeft = 1,
    VerticalDown = 2,
    HorizontalRight = 3,
}
DroppablePairOrientation;

@interface DroppablePair : GemAggregate 

@property (readonly) DroppablePairOrientation orientation;

@property (readonly) Gem* pivot;
@property (readonly) Gem* buddy;

- (id) initAt: (GridCell) cell_ with: (GemType[]) gems resources: (ResourceManager*) resources;

- (DroppablePair*) rotateLeft;

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end