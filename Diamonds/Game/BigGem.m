//
//  BigGem.m
//  Diamonds

#import "BigGem.h"
#import "Grid.h"

#import "TiledSprite.h"

@interface Droppable (private)

- (void) setCell: (GridCell) cell_;

- (void) setWidth: (int) width_;
- (void) setHeight: (int) height_;

@end

@interface Gem (private)

- (Sprite*) sprite;

- (bool) isCellCandidateToFormBigGem: (GridCell) cell_;

@end

@implementation BigGem 

- (Class) spriteClass
{
    return [TiledSprite class];
}

- (NSString*) textureFolder
{
    return @"BigGems";
}

- (TiledSprite*) tiledSprite
{
    return (TiledSprite*) self.sprite;
}

- (void) setUpTiles
{
    [self.tiledSprite setTileSize: CGSizeMake(32, 32)];
    
    for (int j = 0; j < self.height; ++j)
    {
        for (int i = 0; i < self.width; ++i)
        {
            TileCoordinates tile = MakeTile(1, 1);
                        
            if (i == 0 && j == 0)
                tile = MakeTile(0, 0);
            else
            if (i == self.width - 1 && j == 0)
                tile = MakeTile(2, 0);
            else
            if (i == 0 && j == self.height - 1)
                tile = MakeTile(0, 2);
            else
            if (i == self.width -1 && j == self.height - 1)
                tile = MakeTile(2, 2);
        
            [self.tiledSprite setTile: MakeTile(i, j) with: tile];            
        }
    }

    [self.tiledSprite updateSizeFromTiles];
}

- (id) initWithType: (GemType) gemType at: (GridCell) cell_ grid: (Grid*) grid_ width: (int) width_ height: (int) height_
{
    self = [super initWithType: gemType at: cell_ grid: grid_];
    if (self == nil)
        return nil;
    
    [self setWidth: width_];
    [self setHeight: height_];

    [self setUpTiles];
    
    return self;
}

- (bool) isColumnCandidateToFormBigGem: (int) column height: (int) height
{
    for (int i = self.cell.row; i < self.cell.row + height; ++i)
    {
        if (![self isCellCandidateToFormBigGem: MakeCell(column, i)])
        {
            return NO;
        }
    }
    
    return YES;
    
}

- (void) extendLeft
{
    int column = self.cell.column - 1;
    
    while ([self isColumnCandidateToFormBigGem: column height: self.height])
    {
        --column;        
    }
    
    [self setWidth: self.width + (self.cell.column - column - 1)];
    [self setCell: MakeCell(column + 1, self.cell.row)];
}

- (void) extendRight
{
    int column = self.cell.column + self.width;
    
    while ([self isColumnCandidateToFormBigGem: column height: self.height])
    {
        ++column;        
    }
    
    [self setWidth: column - self.cell.column];
}

- (BigGem*) formBigGem
{
    [self extendRight];    
    [self extendLeft]; 
    
    [self placeIn: self.grid];
    
    return self;
}

- (void) placeIn: (Grid*) grid
{
    [grid remove: self];

    for (int j = 0; j < self.height; ++j)
    {
        for (int i = 0; i < self.width; ++i)
        {
            GridCell gemCell = MakeCell(self.cell.column + i, self.cell.row + j);
            Droppable* droppable = [grid get: gemCell];
            [grid remove: droppable];            
        }
    }
    
    [grid put: self];
}

@end
