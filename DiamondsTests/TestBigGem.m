//
//  MyClass.m
//  Diamonds

#import "TestBigGem.h"

#import "BigGem.h"
#import "Grid.h"
#import "GridController.h"
#import "GridController+Testing.h"

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

@end

