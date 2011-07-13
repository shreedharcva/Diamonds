//
//  TestGem.h
//  Diamonds

#import "Testing.h"
#import "Gem.h"

@interface TestGemBase : TestCase
{
    Gem* gem;
}

- (void) makeGem: (GemType) type;
- (void) makeGem: (GemType) type at: (GridPosition) position;


@end
