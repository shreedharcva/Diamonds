//
//  TestGem.m
//  Diamonds

#import "TestGem.h"

#import "GemAggregate.h"
#import "DroppablePair.h"

#import "Gem.h"

#import "MockSpriteBatch.h"
#import "MockResourceManager.h"
#import "MockTexture.h"

@interface TestDroppablePair : TestCase 
@end

@implementation TestDroppablePair
{
    DroppablePair* pair;
}

- (void) setUp
{
    [super setUp];
    
    GemType gems[2];    
    gems[0] = Diamond;
    gems[1] = Ruby;
    
    pair = [[DroppablePair alloc] initAt: MakeCell(4, 12) with: gems resources: nil];    
}

- (void) testDroppablePairSizeIs1x2
{
    assertEquals(1, pair.width);
    assertEquals(2, pair.height);
}

- (void) testDroppablePairIsCreatedWithCorrectPivotAndBuddy
{    
    assertEquals(Diamond, pair.pivot.type);
    assertEquals(Ruby, pair.buddy.type);
}

- (void) testDroppablePairIsCreatedWithPivotAndBuddyAndSprites
{    
    assertNotNil([pair.pivot sprite]);
    assertNotNil([pair.buddy sprite]);
}

- (void) testDroppablePairIsCreatedWithTheCorrectCell
{
    assertEquals(MakeCell(4, 12), pair.cell);    
}

- (void) testDroppablePairCreatesTwoGemsAtTheCorrectCells
{
    assertEquals(MakeCell(4, 12), pair.pivot.cell);    
    assertEquals(MakeCell(4, 13), pair.buddy.cell);    
}

@end

@interface TestDroppablePairDrawing : TestGemDrawingBase 
@end

@implementation TestDroppablePairDrawing
{    
    DroppablePair* pair;
}

- (void) makePairAt: (GridCell) cell
{
    MockResourceManager* resources = [MockResourceManager new];
    
    GemType gems[2];    
    gems[0] = Diamond;
    gems[1] = Ruby;
    
    pair = [[DroppablePair alloc] initAt: cell with: gems resources: resources];        
}

- (void) testDroppablePairDrawsTwoSprites
{
    [self makePairAt: MakeCell(4, 13)];

    [batch begin];
    [pair drawIn: batch info: info];
    [batch end];    

    assertEquals(2, batch.numberOfSpritesDrawn);
}

- (void) testDroppablePairDrawsTwoSpritesWithTheCorrectTextures
{
    [self makePairAt: MakeCell(4, 13)];
    
    [batch begin];
    [pair drawIn: batch info: info];
    [batch end];    
    
    assertEqualObjects(@"diamond", [[batch.sprites objectAtIndex: 0] texture].name);
    assertEqualObjects(@"ruby", [[batch.sprites objectAtIndex: 1] texture].name);
}

@end