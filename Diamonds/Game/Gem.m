//
//  Gem.m
//  Diamonds

#import "Gem.h"
#import "BigGem.h"

#import "Sprite.h"
#import "SpriteBatch.h"
#import "ResourceManager.h"
#import "Grid.h"
#import "GemAggregate.h"

@interface Gem (private)
@property (readonly) Sprite* sprite;
@end

@implementation Gem
{        
    Sprite* sprite;
}

@synthesize type;

- (Class) spriteClass
{
    return [Sprite class];
}

- (NSString*) getTextureNameFromType: (GemType) gemType
{
    if (gemType == Diamond)
        return @"diamond";
    if (gemType == Ruby)
        return @"ruby";
    if (gemType == Sapphire)
        return @"sapphire";
    
    return nil;
}

- (NSString*) textureFolder
{
    return nil;
}

- (Texture*) getTextureFromType: (GemType) gemType resources: (ResourceManager*) resources
{
    if (gemType == EmptyGem)
        return nil;
    
    return [resources loadTexture: [self getTextureNameFromType: gemType] from: [self textureFolder]];
}

- (void) initSpriteForType: (GemType) gemType resources: (ResourceManager*) resources   
{
    Texture* texture = [self getTextureFromType: gemType resources: resources];
    sprite = [[[self spriteClass] alloc] initWithTexture: texture];

    [sprite setSourceRectangle: CGRectMake(0, 0, 32, 32)];
    [sprite resizeTo: CGSizeMake(32, 32)];
}

- (id) initWithType: (GemType) gemType at: (GridCell) cell_ grid: (Grid*) grid_
{
    self = [super initWithGrid: grid_ at: cell_ width: 1 height: 1];
    if (self == nil)
        return nil;

    type = gemType;
    
    [self initSpriteForType: gemType resources: self.grid.resources];

    return self;
}

- (bool) isCellCandidateToFormBigGem: (GridCell) cell_
{
    Droppable* droppable = [self.grid get: cell_];
    
    if (![droppable isKindOfClass: [Gem class]])
    {
        return NO;
    }
    
    Gem* gem = (Gem*) droppable;
    
    if ([gem type] != [self type])
    {
        return NO;
    }            
    
    return YES;
}

- (bool) isRowCandidateToFormBigGem: (int) row_ width: (int) width_
{
    for (int i = self.cell.column; i < self.cell.column + width_; ++i)
    {
        if (![self isCellCandidateToFormBigGem: MakeCell(i, row_)])
        {
            return NO;
        }
    }
    
    return YES;
}

- (BigGem*) formBigGem
{
    // TODO: Refactor this method
    
    if (self.grid == nil)
        return nil;
    
    int i = self.cell.column;
    int j = self.cell.row;
    
    while ([self isCellCandidateToFormBigGem: MakeCell(i, j)])
    {
        ++i;
    }
    
    int bigGemWidth = i - self.cell.column; 
    if (bigGemWidth < 2)
    {
        return nil;
    }
    
    while ([self isRowCandidateToFormBigGem: j width: bigGemWidth])
    {
        ++j;
    }

    int bigGemHeight = j - self.cell.row; 
    if (bigGemHeight < 2)
    {
        return nil;
    }
    
    if (bigGemWidth < self.width || bigGemHeight < self.height)
    {
        return nil;
    }
    
    BigGem* bigGem = [[BigGem alloc] initWithType: self.type at: self.cell grid: self.grid width: bigGemWidth height: bigGemHeight];

    [bigGem placeInGrid];
    
    return bigGem;
}

- (void) drawIn: (SpriteBatch*) batch info: (GridPresentationInfo) info;
{ 
    CGPoint spritePosition = info.origin;
    
    spritePosition.x += info.cellSize.width * self.cell.column; 
    
    // TODO: refactor
    spritePosition.y -= info.cellSize.height * (self.cell.row);
    spritePosition.y -= info.cellSize.height * (self.height - 1);
    spritePosition.y += (info.cellSize.height * (info.heightInCells - 1)); 
    spritePosition.y += (-self.cellHeight) * info.cellSize.height;
    
    [sprite moveTo: spritePosition];
    [sprite drawIn: batch];
}

- (NSString*) description
{
    NSString* typeString = @"NoType";
    
    if (type == Diamond)
        typeString =  @"Diamond";
    if (type == Ruby)
        typeString =  @"Ruby";
    if (type == Sapphire)
        typeString =  @"Sapphire";
    
    return [NSString stringWithFormat: @"[%p] %@ (%d %d)", self, typeString, self.cell.column, self.cell.row]; 
}

- (Sprite*) sprite
{
    return sprite;
}

@end
