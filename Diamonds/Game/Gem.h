//
//  Gem.h
//  Diamonds

typedef struct GridPresentationInfo
{
    CGPoint origin;
    CGSize cellSize;

    int heightInCells;
}
GridPresentationInfo;

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

- (id) initWithType: (GemType) gemType at: (GridPosition) gridPosition resources: (ResourceManager*) resources;

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end
