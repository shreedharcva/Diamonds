//
//  TestGem.h
//  Diamonds

#import "Testing.h"
#import "Gem.h"

@class MockSpriteBatch;
@class Sprite;
@class Grid;

@interface TestGemBase : TestCase
{
    Gem* gem;
}

@property (readonly) Grid* grid;

- (Gem*) makeGem: (GemType) type;
- (Gem*) makeGem: (GemType) type at: (GridCell) cell;

@end

@interface TestGemDrawingBase : TestGemBase 
{
    MockSpriteBatch* batch;    
    GridPresentationInfo info;
}

@end

@interface Gem (Testing)

- (void) setCellHeight: (float) height;
- (Sprite*) sprite;

@end

