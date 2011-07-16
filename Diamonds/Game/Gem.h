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
    Sapphire = 3,
}
GemType;

typedef enum GemState
{
    NoGemState = 0,
    Stopped = 1,
    Falling = 2,
}
GemState;

typedef struct GridPosition
{
    int column;
    int row;
}
GridPosition;

typedef GridPosition GridCell;

GridCell MakeCell(int column, int row);

@class SpriteBatch;
@class ResourceManager;
@class Grid;

@interface Droppable : NSObject

@property (readonly, nonatomic) int width;
@property (readonly, nonatomic) int height;

@property (readonly) GridCell cell;

- (id) initAt: (GridCell) cell_ width: (int) width_ height: (int) height_;

@end

@interface Gem : Droppable
{
    float cellHeight;
}

@property (readonly) GemType type;
@property (readonly) GemState state;

@property (readonly) float cellHeight;

- (id) initWithType: (GemType) gemType at: (GridCell) cell resources: (ResourceManager*) resources;

- (void) moveRightOn: (Grid*) grid;
- (void) moveLeftOn: (Grid*) grid;

- (void) updateWithGravity: (float) gravity onGrid: (Grid*) grid;

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end

@interface DroppablePair : Droppable 

@property (readonly) Gem* pivot;
@property (readonly) Gem* buddy;

- (id) initAt: (GridCell) cell_ with: (GemType[]) gems resources: (ResourceManager*) resources;
- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end