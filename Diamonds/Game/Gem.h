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
{
    GemType type; 
}

- (id) initWithType: (GemType) gemType at: (GridCell) cell grid: (Grid*) grid_;

- (BigGem*) formBigGem;

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;

@property (readonly) GemType type;

@end

