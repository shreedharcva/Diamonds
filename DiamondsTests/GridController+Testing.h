//
//  GridController+Testing.h
//  Diamonds

#import "GridController.h"
#import "Grid.h"

@interface GridController (Testing)

- (void) parseGridAt: (GridCell) originCell from: (NSString*) string;
- (void) parseGridFrom: (NSString*) string;

@end
