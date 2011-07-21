//
//  DroppablePair.h
//  Diamonds

#import "Gem.h"
#import "GemAggregate.h"

@interface DroppablePair : GemAggregate 

@property (readonly) Gem* pivot;
@property (readonly) Gem* buddy;

- (id) initAt: (GridCell) cell_ with: (GemType[]) gems resources: (ResourceManager*) resources;

- (void) rotateLeft;
- (void) rotateRight;

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end