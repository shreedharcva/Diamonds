//
//  Droppable.h
//  Diamonds

typedef struct GridPresentationInfo
{
    CGPoint origin;
    CGSize cellSize;
    
    int heightInCells;
}
GridPresentationInfo;

typedef enum DroppableState
{
    NoGemState = 0,
    Stopped = 1,
    Falling = 2,
}
DroppableState;

typedef struct GridCell
{
    int column;
    int row;
}
GridCell;

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

@property (readonly) DroppableState state;

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