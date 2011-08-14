//
//  Grid.h
//  Diamonds

#import "Gem.h"

@class Droppable;

@interface Grid : NSObject
{
    NSMutableSet* droppables;
}

+ (GridCell) origin;

- (id) initWithResources: (ResourceManager*) resourceManager width: (int) width_ height: (int) height_;

- (bool) isEmpty;
- (bool) isCellEmpty: (GridCell) cell;
- (bool) isCellValid: (GridCell) cell;

- (bool) isAreaEmptyAt: (GridCell) cell width: (int) width_ height: (int) height_;
- (bool) isAreaEmptyAt: (GridCell) cell width: (int) width_ height: (int) height_ ignore: (Droppable*) ignore;

- (Droppable*) put: (Droppable*) droppable;
- (Gem*) put: (GemType) type at: (GridCell) cell;

- (Droppable*) get: (GridCell) cell;

- (Grid*) remove: (Droppable*) droppable;

- (void) updateWithGravity: (float) gravity;

@property (readonly) NSArray* droppables;
@property (readonly) NSArray* bigGems;

@property (readonly, nonatomic) int width;
@property (readonly, nonatomic) int height;

@property (readonly, nonatomic) GridCell spawnCell;
@property (readonly, nonatomic) GridCell origin;

@property (readonly) ResourceManager* resources;

@end

@class ResourceManager;
@class Sprite;

@interface GridDrawer : NSObject

- (id) initWithGrid: (Grid*) grid_ info: (GridPresentationInfo) presentationInfo;

- (void) setBackground: (Sprite*) background;

- (void) drawBackgroundIn: (SpriteBatch*) batch;
- (void) drawIn: (SpriteBatch*) batch;

@end