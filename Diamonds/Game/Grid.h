//
//  Grid.h
//  Diamonds

#import "Gem.h"

@class Droppable;

@interface Grid : NSObject

@property (readonly) NSArray* droppables;

- (id) initWithResources: (ResourceManager*) resourceManager width: (int) gridWidth height: (int) gridHeight;

- (bool) isEmpty;
- (bool) isCellEmpty: (GridCell) cell;
- (bool) isCellValid: (GridCell) cell;

- (Droppable*) put: (Droppable*) droppable;
- (Gem*) put: (GemType) type at: (GridCell) cell;

- (Droppable*) get: (GridCell) cell;

- (void) remove: (Droppable*) droppable;

- (void) updateWithGravity: (float) gravity;

@property (readonly) int width;
@property (readonly) int height;

@property (readonly) ResourceManager* resources;

@end

@class ResourceManager;
@class Sprite;

@interface GridDrawer : NSObject

- (id) initWithGrid: (Grid*) gridToDraw info: (GridPresentationInfo) presentationInfo;

- (void) setBackground: (Sprite*) background;

- (void) drawBackgroundIn: (SpriteBatch*) batch;
- (void) drawIn: (SpriteBatch*) batch;

@end