//
//  MyClass.m
//  Diamonds

#import "TestBigGem.h"

#import "BigGem.h"
#import "Grid.h"
#import "GridController.h"
#import "GridController+Testing.h"

#import "TiledSprite.h"

#import "MockSpriteBatch.h"
#import "MockEngine.h"
#import "MockTexture.h"
#import "MockResourceManager.h"

@implementation TestBigGemBase

- (BigGem*) formBigGemAt: (GridCell) cell
{
    return [[controller.grid get: cell] formBigGem];    
}

- (BigGem*) formBigGem
{
    return [self formBigGemAt: [Grid origin]];    
}

- (BigGem*) bigGemAt: (GridCell) cell
{
    return (BigGem*) [controller.grid get: cell];
}

- (BigGem*) bigGem
{
    return [self bigGemAt: [Grid origin]];
}

- (Gem*) gemAt: (GridCell) cell
{
    return (Gem*) [controller.grid get: cell];
}

@end

@interface TestBigGem :  TestBigGemBase 
@end

@implementation TestBigGem 

- (void) testFormBigGemReturnsNilForASingleGem
{
    [controller parseGridFrom: @"D"];    
    
    assertNil([self formBigGem]);
}

- (void) testFormBigGemReturnsABigGemIfPartOfASquareOfGemsOfTheSameType
{
    [controller parseGridFrom: 
     @"dd\n"
     @"dd"];    
    
    assertNotNil([self formBigGem]);
}

- (void) testABigGemReplacesASquareOfGemsOfTheSameType
{
    [controller parseGridFrom: 
     @"dd\n"
     @"dd"];    
    
    [self formBigGem];
    
    assertIsKindOfClass(BigGem, [self bigGem]);    
}

- (void) testBigGemFormedIs2X2
{
    [controller parseGridFrom: 
     @"dd\n"
     @"dd"];    
    
    BigGem* bigGem = [self formBigGem];
    
    assertEquals(2, bigGem.width);    
    assertEquals(2, bigGem.height);    
}

- (void) testABigGemIsOfTheSameTypeOfTheGemsItReplaced
{
    [controller parseGridAt: MakeCell(1, 0) from: 
     @"dd\n"
     @"dd"];    
    
    [self formBigGemAt: MakeCell(1, 0)];
    
    assertEquals(Diamond, [self bigGemAt: MakeCell(1, 0)].type);    
}

- (void) testFormBigGemReturnsABigGemIfPartOf3X2BlockOfGemsOfTheSameType
{
    [controller parseGridFrom: 
     @"ddd\n"
     @"ddd"];    
    
    assertNotNil([self formBigGem]);
}

- (void) testBigGemFormedIs3X2
{
    [controller parseGridFrom: 
     @"ddd\n"
     @"ddd"];    
    
    BigGem* bigGem = [self formBigGem];
    
    assertEquals(3, bigGem.width);    
    assertEquals(2, bigGem.height);    
}

- (void) testBigGemFormedIs3X3
{
    [controller parseGridFrom: 
     @"ddd\n"
     @"ddd\n"
     @"ddd"];    
    
    BigGem* bigGem = [self formBigGem];
    
    assertEquals(3, bigGem.width);    
    assertEquals(3, bigGem.height);    
}

- (void) testBigGemIsExtendedByTwoMoreHorizontalGems
{
    [controller parseGridFrom: 
     @"DDd\n"
     @"DDd"];    
    
    BigGem* bigGem = [self formBigGem];
    
    assertEquals(3, bigGem.width);    
    assertEquals(2, bigGem.height);    
}

- (void) testBigGemIsNotExtendedIfTheresAGap
{
    [controller parseGridFrom: 
     @"DD.d\n"
     @"DDdd"];    
    
    [self formBigGem];
    
    assertEquals(2, [self bigGem].width);    
    assertEquals(2, [self bigGem].height);    
}

- (void) testBigGemIsNotExtendedIfTheresAGapOnTheThirdRow
{
    [controller parseGridFrom: 
     @"DD.d\n"
     @"DDdd\n"
     @"DDdd"];    
    
    NSLog(@"%@", controller);
    
    [self formBigGem];
    
    assertEquals(2, [self bigGem].width);    
    assertEquals(3, [self bigGem].height);    
}

- (void) testBigGemIsFormedAfterAnUpdate
{
    [controller parseGridFrom: 
     @"ddd\n"
     @"ddd"];        

    [controller update];
    
    assertEquals(3, [self bigGem].width);    
    assertEquals(2, [self bigGem].height);    
}

/*
- (void) testBigGemIsFormedWhenTheFirstRowIsLongerThanTheFinalWidth
{
    [controller parseGridFrom: 
     @"dd.\n"
     @"ddd"];        
    
    [controller update];
    
    assertEquals(2, [self bigGem].width);    
    assertEquals(2, [self bigGem].height);    
}
 */

- (void) testBigGemFormedIsFormedOnTheSecondColumn
{
    [controller parseGridFrom: 
     @".dd\n"
     @".dd"];        
    
    [controller update];
    
    assertEquals(2, [self bigGemAt: MakeCell(1, 0)].width);    
    assertEquals(2, [self bigGemAt: MakeCell(1, 0)].height);    
}

- (void) testBigGemIsFormedOnTheSecondColumnWhenTheTextureIsNotSquare
{
    [[resources textureFactory] setTextureSize: CGSizeMake(128, 256)];
    
    [controller parseGridFrom: 
     @".dd\n"
     @".dd"];        
    
    [controller update];
    
    assertEquals(2, [self bigGemAt: MakeCell(1, 0)].width);    
    assertEquals(2, [self bigGemAt: MakeCell(1, 0)].height);    
}

- (void) testGemsDontDisappearWhenTheBigGemIsExtendedUp
{
    [controller parseGridFrom: 
     @"dd.\n"
     @"DDr\n"
     @"DDr"];    
    
    [controller update];
    
    assertEquals(Ruby, [self gemAt: MakeCell(2, 0)].type);    
}

@end


@interface BigGem (testing)
- (TiledSprite*) tiledSprite;
@end

@interface TestBigGemDrawing :  TestBigGemBase 
@end

@implementation TestBigGemDrawing
{
    BigGem* bigGem;
    MockSpriteBatch* batch;
    GridPresentationInfo info;
}

- (void) setUp
{
    [super setUp];
    
    [controller parseGridFrom: 
     @"dddd\n"
     @"dddd"];    
    
    bigGem = [self formBigGem];
    
    info.cellSize = CGSizeMake(32, 32);
    info.heightInCells = 14;
    
    batch = [[MockSpriteBatch alloc] initWithEngine: [MockEngine new]];
}

- (void) testBigGemSpriteClassIsTiledSprite
{
    assertIsKindOfClass(TiledSprite, bigGem.tiledSprite);
}

- (void) testBigGemDrawsSixQuads
{
    [batch begin];
    [bigGem drawIn: batch info: info];
    [batch end];
    
    assertEquals(8, batch.numberOfSpritesDrawn);
}

- (void) testBigGemDrawsQuadsAtTheCorrectPosition
{
    [batch begin];
    [bigGem drawIn: batch info: info];
    [batch end];
    
    assertEquals(CGPointMake(96, 416), batch.lastSprite.position);
}

- (void) testBigGemDrawsQuadsWithTheCorrectSize
{
    [batch begin];
    [bigGem drawIn: batch info: info];
    [batch end];
    
    assertEquals(CGSizeMake(32, 32), batch.lastSprite.size);
}

- (void) testBigGemSpriteUpperLeftTileIsCorrect
{
    assertEquals(MakeTile(0, 0), [bigGem.tiledSprite getTile: MakeTile(0, 0)].source);
}

- (void) testBigGemSpriteUpperRightTileIsCorrect
{
    assertEquals(MakeTile(2, 0), [bigGem.tiledSprite getTile: MakeTile(3, 0)].source);
}

- (void) testBigGemSpriteLowerRightTileIsCorrect
{
    assertEquals(MakeTile(2, 2), [bigGem.tiledSprite getTile: MakeTile(3, 1)].source);
}

@end


