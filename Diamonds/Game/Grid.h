//
//  Grid.h
//  Diamonds

#import "Gem.h"

@class ResourceManager;

@interface Grid : NSObject

@property (readonly) NSArray* gems;

- (id) initWithResources: (ResourceManager*) resourceManager;

- (bool) isEmpty;

- (void) put: (GemType) type at: (GridPosition) origin;
- (Gem*) get: (GridPosition) position;

@end


@interface GridDrawer : NSObject

- (id) initWithGrid: (Grid*) gridToDraw info: (GridPresentationInfo) presentationInfo;

- (void) drawIn: (SpriteBatch*) batch;

@end