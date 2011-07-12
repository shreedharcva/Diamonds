//
//  Grid.h
//  Diamonds

#import "Gem.h"

@interface Grid : NSObject

- (bool) isEmpty;

- (void) put: (GemType) type at: (GridPosition) origin;
- (Gem*) get: (GridPosition) position;

@end
