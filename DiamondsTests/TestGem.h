//
//  TestGem.h
//  Diamonds

#import "Testing.h"
#import "Gem.h"

@interface TestGemBase : TestCase
{
    Gem* gem;
}

- (Gem*) makeGem: (GemType) type;
- (Gem*) makeGem: (GemType) type at: (GridCell) cell;


@end
