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
void MoveCell(GridCell* cell, GridCell delta);

bool CellIsEqualToCell(GridCell left, GridCell right);

typedef enum Direction
{
    Left    = 0,
    Right   = 1,
    Up      = 2,
    Down    = 3,    
} 
Direction;

@class SpriteBatch;
@class ResourceManager;
@class Grid;

@interface Droppable : NSObject
{
    float cellHeight;
}

@property (readonly, nonatomic) Grid* grid;

@property (readonly, nonatomic) int width;
@property (readonly, nonatomic) int height;

@property (readonly) GridCell relativeCell;
@property (readonly) GridCell cell;

@property (readonly) DroppableState state;

@property (readonly) float cellHeight;

@property (weak) Droppable* parent;

- (id) initWithGrid: (Grid*) grid_ at: (GridCell) cell_ width: (int) width_ height: (int) height_;

- (void) detachFromParent;

- (bool) contains: (GridCell) cell_;

- (void) move: (Direction) direction;
- (void) moveRight;
- (void) moveLeft;

- (void) updateWithGravity: (float) gravity;
- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@end