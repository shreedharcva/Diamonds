//
//  GemAggregate.h
//  Diamonds

#include "Droppable.h"

@class Gem;

@interface GemAggregate : Droppable 

- (id) initAt: (GridCell) cell width: (int) width_ height: (int) height_;
- (void) add: (Droppable*) droppable;
- (Gem*) gem: (int) index;

- (void) releaseOn: (Grid*) grid;

@end