//
//  Grid.h
//  Diamonds

#import "Gem.h"

@interface Grid : NSObject

@property (readonly) NSArray* gems;

- (id) initWithResources: (ResourceManager*) resourceManager;

- (bool) isEmpty;

- (void) put: (GemType) type at: (GridPosition) origin;
- (Gem*) get: (GridPosition) position;

- (void) update;

@end

@class ResourceManager;
@class Sprite;

@interface GridDrawer : NSObject

- (id) initWithGrid: (Grid*) gridToDraw info: (GridPresentationInfo) presentationInfo;

- (void) setBackground: (Sprite*) background;

- (void) drawBackgroundIn: (SpriteBatch*) batch;
- (void) drawIn: (SpriteBatch*) batch;

@end