//
//  Engine.h
//  Diamonds


#import <Foundation/Foundation.h>

@class EAGLView;
@class ShaderProgram;
@class Texture;

@interface Engine : NSObject 

- (id) initWithView: (EAGLView*) glview;

- (void) loadShaders;
- (void) loadTextures;

- (void) drawFrame;

@end
