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

typedef struct DroppableSize
{
    int width;
    int height;
}
DroppableSize;

DroppableSize MakeSize(int width, int height);

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
@class BigGem;

@interface Droppable : NSObject
{
@private
    int width;
    int height;

    DroppableState state;
    GridCell cell;
}

- (id) initWithGrid: (Grid*) grid_ at: (GridCell) cell_ width: (int) width_ height: (int) height_;

- (void) attachToGrid: (Grid*) grid_;

- (void) detachFromParent;
- (void) detachFromGrid;

- (bool) contains: (GridCell) cell_;

- (void) move: (Direction) direction;
- (void) moveRight;
- (void) moveLeft;

- (BigGem*) formBigGem;

- (void) updateWithGravity: (float) gravity;
- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@property (readonly, nonatomic) Grid* grid;

@property (readonly, nonatomic) int width;
@property (readonly, nonatomic) int height;

@property (readonly, nonatomic) GridCell relativeCell;
@property (readonly, nonatomic) GridCell cell;

@property (readonly, nonatomic) DroppableState state;

@property (readonly, nonatomic) float cellHeight;

@property (weak) Droppable* parent;

@end