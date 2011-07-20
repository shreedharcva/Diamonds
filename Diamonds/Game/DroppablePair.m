//
//  DroppablePair.m
//  Diamonds

#import "DroppablePair.h"

#import "Gem.h"

typedef struct OrientationState
{
    DroppablePairOrientation left;
    DroppablePairOrientation right;
    
    GridCell pivotCell;
    GridCell buddyCell;

    int width;
    int height;    
}
OrientationState;

OrientationState orientationStates[4] =
{
    { HorizontalLeft, HorizontalRight, {  0,  1 }, {  0,  0 }, 1, 2 },               // VerticalUp
    { HorizontalLeft, HorizontalRight, { -1,  0 }, { -1,  0 }, 2, 1 },               // VerticalUp
    { HorizontalLeft, HorizontalRight, { -1,  0 }, {  0,  0 }, 0, 0 },               // VerticalUp
    { HorizontalLeft, HorizontalRight, { -1,  0 }, {  0,  0 }, 0, 0 },               // VerticalUp
};

@interface Droppable (private)

- (void) setWidth: (int) width_;
- (void) setHeight: (int) height_;

- (void) setCell: (GridCell) cell_;

@end

@implementation DroppablePair
{
    DroppablePairOrientation orientation;
    
    Gem* buddy;
    Gem* pivot;
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
    
    pivot = [self addGem: gems[0] at: MakeCell(0, 0) resources: resources];
    buddy = [self addGem: gems[1] at: MakeCell(0, 1) resources: resources];
    
    return self;
}

- (DroppablePair*) rotateLeft
{
    orientation = orientationStates[orientation].left;
    
    [self setWidth: orientationStates[orientation].width]; 
    [self setHeight: orientationStates[orientation].height];
    
    [self.buddy setCell: orientationStates[orientation].buddyCell];
    
    return nil;
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