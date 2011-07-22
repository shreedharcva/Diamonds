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

- (bool) isAreaEmptyAt: (GridCell) cell width: (int) width_ height: (int) height_;
- (bool) isAreaEmptyAt: (GridCell) cell width: (int) width_ height: (int) height_ ignore: (Droppable*) ignore;

- (Droppable*) put: (Droppable*) droppable;
- (Gem*) put: (GemType) type at: (GridCell) cell;

- (Droppable*) get: (GridCell) cell;

- (void) remove: (Droppable*) droppable;

- (void) updateWithGravity: (float) gravity;

@property (readonly, nonatomic) int width;
@property (readonly, nonatomic) int height;

@property (readonly, nonatomic) GridCell spawnCell;

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