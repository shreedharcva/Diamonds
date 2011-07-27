//
//  GemAggregate.h
//  Diamonds

#include "Droppable.h"
#include "Gem.h"

@class Gem;

@interface GemAggregate : Droppable 

- (id) initWithGrid: (Grid*) grid_ at: (GridCell) cell_ width: (int) width_ height: (int) height_;
- (void) add: (Droppable*) droppable;
- (Gem*) gem: (int) index;

- (void) releaseOnGrid;

@end
