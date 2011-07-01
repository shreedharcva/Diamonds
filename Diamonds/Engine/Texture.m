//
//  Texture.m
//  Diamonds

#import "Texture.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@implementation Texture
{
    NSString* name;
    
    GLuint texture;
    CGSize size;
}

@synthesize size;
@synthesize name;

- (id) initWithName: (NSString*) textureName
{
    self = [super init];
    if (self == nil)
    {
        return nil;
    }

    name = textureName;
    
    return self;
}

- (void) load
{
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR); 
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    
    NSString *path = [[NSBundle mainBundle] pathForResource: self.name ofType:@"png"];
    NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *image = [[UIImage alloc] initWithData:texData];
    
    if (image == nil)
    {
        NSLog(@"Do real error checking here");
    }
    
    size.width = CGImageGetWidth(image.CGImage);
    size.height = CGImageGetHeight(image.CGImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    void* imageData = malloc(size.height * size.width * 4);
    
    CGContextRef context = CGBitmapContextCreate(imageData, size.width, size.height, 8, 4 * size.width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    
    CGColorSpaceRelease( colorSpace );
    
    CGContextClearRect( context, CGRectMake(0, 0, size.width, size.height ) );
    CGContextTranslateCTM( context, 0, size.height - size.height );
    CGContextDrawImage( context, CGRectMake( 0, 0, size.width, size.height ), image.CGImage );
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, size.width, size.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    CGContextRelease(context);
    
    free(imageData);    
}

- (void) bind
{
    glBindTexture(GL_TEXTURE_2D, texture);
}

@end

@implementation TextureFactory

- (Texture*) create: (NSString*) name
{
    return [[Texture alloc] initWithName: name];
}

@end
