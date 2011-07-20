//
//  TestGem.m
//  Diamonds

#import "TestGem.h"

#import "Texture.h"
#import "ResourceManager.h"
#import "Grid.h"
#import "GemAggregate.h"
#import "DroppablePair.h"

#import "MockSpriteBatch.h"
#import "MockResourceManager.h"
#import "MockTexture.h"


@implementation TestGemBase

- (Gem*) makeGem: (GemType) type
{
    return [self makeGem: type at: MakeCell(0, 0)];
}

- (Gem*) makeGem: (GemType) type at: (GridCell) cell
{
    ResourceManager* resourceManager = [ResourceManager new];    
    gem = [[Gem alloc] initWithType: type at: cell resources: resourceManager];    
    return gem;
}

@end

@interface TestGem : TestGemBase 
@end

@implementation TestGem

- (void) testGemSizeIs1x1
{
    [self makeGem: Diamond];
    
    assertEquals(1, gem.width);
    assertEquals(1, gem.height);    
}

- (void) testGemHasNoParentsWhenItsDetached
{
    Gem* parent = [self makeGem: Diamond at: MakeCell(1, 1)];
    Gem* child = [self makeGem: Diamond at: MakeCell(1, 1)];
    
    child.parent = parent;
    [child detachFromParent];
    
    assertNil(child.parent);    
}

- (void) testGemCellIsUpdatedWhenGemIsDetachedFromParent
{
    Gem* parent = [self makeGem: Diamond at: MakeCell(1, 1)];
    Gem* child = [self makeGem: Diamond at: MakeCell(1, 1)];
    
    child.parent = parent;
    [child detachFromParent];
    
    assertEquals(MakeCell(2, 2), child.cell);
}

@end
