//
//  Texture.h
//  Diamonds


@interface Texture : NSObject 
{
    CGSize size;
}

@property (readonly, nonatomic) CGSize size;

- (void) load;
- (void) bind;

@end