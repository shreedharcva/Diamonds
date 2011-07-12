//
//  Grid.h
//  Diamonds

typedef enum GemType 
{
    EmptyGem = 0,
    Diamond = 1,
    Ruby = 2,
}
GemType;

typedef struct GridPosition
{
    int column;
    int row;
}
GridPosition;

GridPosition MakePosition(int column, int row);

@class SpriteBatch;
@class ResourceManager;

@interface Gem : NSObject

@property (readonly) GemType type;
@property (readonly) GridPosition position;

- (id) initWithType: (GemType) gemType at: (GridPosition) newPosition resources: (ResourceManager*) resources;

- (void) drawIn: (SpriteBatch*) batch at: (CGPoint) position;

@end


@interface Grid : NSObject

- (bool) isEmpty;

- (void) put: (GemType) type at: (GridPosition) origin;
- (Gem*) get: (GridPosition) position;

@end
