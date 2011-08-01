//
//  BigGem.h
//  Diamonds

#import "Gem.h"

@interface BigGem : Gem 

- (id) initWithType: (GemType) gemType at: (GridCell) cell grid: (Grid*) grid_ width: (int) width_ height: (int) height_;

- (void) placeInGrid;

@end