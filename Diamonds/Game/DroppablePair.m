//
//  DroppablePair.m
//  Diamonds

#import "DroppablePair.h"

#import "Grid.h"
#import "Gem.h"

typedef struct OrientationState
{
    PairOrientation left;
    PairOrientation right;
        
    int width;
    int height;
    
    GridCell pivotCell;
    GridCell buddyCell;
    GridCell baseCellRelativeToPivot;
    
    GridCell rotationCheckRelativeToPivot[2];
    
} OrientationState;

OrientationState orientations[] =
{
    { HorizontalLeft,   HorizontalRight,    1, 2, { 0, 0 }, { 0, 1 }, {  0,  0 }, { { -1,  0 }, {  1,  0 } } },
    { VerticalDown,     VerticalUp,         2, 1, { 1, 0 }, { 0, 0 }, { -1,  0 }, { {  0, -1 }, {  0, -1 } } },
    { HorizontalRight,  HorizontalLeft,     1, 2, { 0, 1 }, { 0, 0 }, {  0, -1 }, { {  1,  0 }, {  0, -1 } } },
    { VerticalUp,       VerticalDown,       2, 1, { 0, 0 }, { 1, 0 }, {  0,  0 }, { {  0,  1 }, {  1,  0 } } },
};

float droppingGravity = 10.0f;

@interface Droppable (private)

- (void) setWidth: (int) width_;
- (void) setHeight: (int) height_;

- (void) setState: (DroppableState) state_;

- (void) setCell: (GridCell) cell_;

@end

@implementation DroppablePair
{
    Gem* buddy;
    Gem* pivot;
    
    PairOrientation orientation;
    
    bool isDropping;
}

@synthesize orientation;
@synthesize pivot;
@synthesize buddy;

+ (void) setDroppingGravity: (float) droppingGravity_
{
    droppingGravity = droppingGravity_;
}

- (Gem*) addGem: (GemType) gemType at: (GridCell) cell_
{
    Gem* gem = [[Gem alloc] initWithType: gemType at: cell_ grid: self.grid];
    [self add: gem];
    return gem;    
}

- (id) initWithGrid: (Grid*) grid_ at: (GridCell) cell_ with: (GemType[]) gems 
{
    self = [super initWithGrid: grid_ at: cell_ width: 1 height: 2];
    if (self == nil)
    {
        return nil;
    }

    orientation = VerticalUp; 

    pivot = [self addGem: gems[0] at: MakeCell(0, 0)];
    buddy = [self addGem: gems[1] at: MakeCell(0, 1)];
    
    [self setState: Falling];
    
    return self;
}

- (void) updatePairAfterRotation
{
    OrientationState state = orientations[orientation]; 
    
    [self setWidth: state.width]; 
    [self setHeight: state.height]; 
    
    GridCell newBaseCell = self.pivot.cell;
    MoveCell(&newBaseCell, state.baseCellRelativeToPivot);
    
    [self setCell: newBaseCell];
    
    [self.pivot setCell: state.pivotCell];
    [self.buddy setCell: state.buddyCell];    
}

- (bool) canRotate: (Direction) direction 
{
    if (self.grid == nil)
        return true;
    
    GridCell cellToTest = self.cell;
    MoveCell(&cellToTest, orientations[orientation].rotationCheckRelativeToPivot[direction]);
    
    return [self.grid isAreaEmptyAt: cellToTest width: self.width height: self.height ignore: self];
}

- (void) rotateLeft
{
    if ([self canRotate: Left])
    {
        orientation = orientations[orientation].left;
        [self updatePairAfterRotation];        
    }
}

- (void) rotateRight
{
    if ([self canRotate: Right])
    {
        orientation = orientations[orientation].right;
        [self updatePairAfterRotation];    
    }
}

- (void) drop
{
    isDropping = true;
}

- (bool) isDropping
{
    return isDropping;
}

- (void) updateWithGravity: (float) gravity
{
    if (isDropping)
    {
        gravity = droppingGravity;
    }
    [super updateWithGravity: gravity];
}

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info
{
    [pivot drawIn: batch info: info];
    [buddy drawIn: batch info: info];
}

- (NSString*) description
{
    return [NSString stringWithFormat: @"[%p] DroppablePair <%@, %@>", self, pivot, buddy];
}

@end