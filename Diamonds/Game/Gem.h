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
{
    float cellHeight;
}

@property (readonly, nonatomic) int width;
@property (readonly, nonatomic) int height;

@property (readonly) GridCell relativeCell;
@property (readonly) GridCell cell;

@property (readonly) GemState state;

@property (readonly) float cellHeight;

@property (weak) Droppable* parent;

- (id) initAt: (GridCell) cell_ width: (int) width_ height: (int) height_;

- (void) detachFromParent;

- (bool) contains: (GridCell) cell_;

- (void) moveRightOn: (Grid*) grid;
- (void) moveLeftOn: (Grid*) grid;

- (void) updateWithGravity: (float) gravity onGrid: (Grid*) grid;
- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end

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