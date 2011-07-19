//
//  Gem.h
//  Diamonds

#import "Droppable.h"

typedef enum GemType 
{
    EmptyGem = 0,
    Diamond = 1,
    Ruby = 2,
    Sapphire = 3,
}
GemType;

@interface Gem : Droppable

@property (readonly) GemType type;

- (id) initWithType: (GemType) gemType at: (GridCell) cell resources: (ResourceManager*) resources;

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end

@interface GemAggregate : Droppable 

- (id) initAt: (GridCell) cell width: (int) width_ height: (int) height_;
- (void) add: (Droppable*) droppable;
- (Gem*) gem: (int) index;

- (void) releaseOn: (Grid*) grid;

@end

@interface DroppablePair : GemAggregate 

@property (readonly) Gem* pivot;
@property (readonly) Gem* buddy;

- (id) initAt: (GridCell) cell_ with: (GemType[]) gems resources: (ResourceManager*) resources;

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end