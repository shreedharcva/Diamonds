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
    
} OrientationState;


OrientationState orientations[] =
{
    { HorizontalLeft,   HorizontalRight,    1, 2, { 0, 0 }, { 0, 1 }, {  0,  0 } },
    { VerticalDown,     VerticalUp,         2, 1, { 1, 0 }, { 0, 0 }, { -1,  0 } },
    { HorizontalRight,  HorizontalLeft,     1, 2, { 0, 1 }, { 0, 0 }, {  0, -1 } },
    { VerticalUp,       VerticalDown,       2, 1, { 0, 0 }, { 1, 0 }, {  0,  0 } },
};

@interface Droppable (private)

- (void) setWidth: (int) width_;
- (void) setHeight: (int) height_;

- (void) setCell: (GridCell) cell_;

@end

@implementation DroppablePair
{
    Gem* buddy;
    Gem* pivot;
    
    PairOrientation orientation;
}

@synthesize orientation;
@synthesize pivot;
@synthesize buddy;

- (Gem*) addGem: (GemType) gemType at: (GridCell) cell_ resources: (ResourceManager*) resources;
{
    Gem* gem = [[Gem alloc] initWithType: gemType at: cell_ resources: resources];
    [self add: gem];
    return gem;    
}

- (id) initAt: (GridCell) cell_ with: (GemType[]) gems resources: (ResourceManager*) resources
{
    self = [super initAt: cell_ width: 1 height: 2];
    if (self == nil)
    {
        return nil;
    }

    orientation = VerticalUp; 

    pivot = [self addGem: gems[0] at: MakeCell(0, 0) resources: resources];
    buddy = [self addGem: gems[1] at: MakeCell(0, 1) resources: resources];
    
    return self;
}

- (void) updatePairAfterRotation
{
    OrientationState state = orientations[orientation]; 
    
    [self setWidth: state.width]; 
    [self setHeight: state.height]; 
    
    GridCell newBaseCell = self.pivot.cell;
    newBaseCell.column += state.baseCellRelativeToPivot.column;
    newBaseCell.row += state.baseCellRelativeToPivot.row;
    
    [self setCell: newBaseCell];
    
    [self.pivot setCell: state.pivotCell];
    [self.buddy setCell: state.buddyCell];    
}

- (void) rotateLeft: (Grid*) grid
{
    /*
    GridCell cellToTest = self.cell;
    
    if (orientation == VerticalUp )
        cellToTest.column -= 1;
    else
    if (orientation == HorizontalLeft)
        cellToTest.row -= 1;
   
    if (![grid isAreaEmptyAt: cellToTest width: self.width height: self.height ignore: self])
    {
        return;
    }
     */
    
    orientation = orientations[orientation].left;
    [self updatePairAfterRotation];
}

- (void) rotateRight: (Grid*) grid
{
    orientation = orientations[orientation].right;
    [self updatePairAfterRotation];    
}

- (void) updateWithGravity: (float) gravity onGrid: (Grid*) grid
{
    [super updateWithGravity: gravity onGrid: grid];
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