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

@interface Gem : NSObject

@property (readonly) GemType type;
@property (readonly) GridPosition position;

- (id) initWithType: (GemType) gemType at: (GridPosition) newPosition;

@end


@interface Grid : NSObject

- (bool) isEmpty;

- (void) put: (GemType) type at: (GridPosition) position;
- (Gem*) get: (GridPosition) position;

@end
