//
//  Grid.h
//  Diamonds

#import "Gem.h"

@interface Grid : NSObject

@property (readonly) NSArray* gems;

- (id) initWithResources: (ResourceManager*) resourceManager width: (int) gridWidth height: (int) gridHeight;

- (bool) isEmpty;
- (bool) isCellEmpty: (GridPosition) position;
- (bool) isCellValid: (GridPosition) position;

- (Gem*) put: (GemType) type at: (GridPosition) origin;
- (Gem*) get: (GridPosition) position;

- (void) updateWithGravity: (float) gravity;

@property (readonly) int width;
@property (readonly) int height;

@end

@class ResourceManager;
@class Sprite;

@interface GridDrawer : NSObject

- (id) initWithGrid: (Grid*) gridToDraw info: (GridPresentationInfo) presentationInfo;

- (void) setBackground: (Sprite*) background;

- (void) drawBackgroundIn: (SpriteBatch*) batch;
- (void) drawIn: (SpriteBatch*) batch;

@end