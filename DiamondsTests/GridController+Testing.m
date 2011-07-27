//
//  GridController+Testing.m
//  Diamonds


#import "GridController+Testing.h"
#import "BigGem.h"

@implementation GridController (Testing)

- (void) parseGridAt: (GridCell) originCell from: (NSString*) string
{
    NSArray* lines = [string componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    

    {
        int row = 0;
        
        for (NSString* line in lines)
        {        
            for (int column = 0; column < [line length]; ++column)
            {
                GridCell cell = MakeCell(
                                         originCell.column + column,
                                         originCell.row - row + [lines count] - 1);
                
                unichar ch = [line characterAtIndex: column];
                if (ch == 'D')
                    [self.grid put: Diamond at: cell];

                
            }
            
            ++row;
        }
    }
    
    for (Droppable* droppable in self.grid.droppables)
    {
        [droppable formBigGem];
    }

    NSLog(@"%@", self);

    {
        int row = 0;

        for (NSString* line in lines)
        {        
            for (int column = 0; column < [line length]; ++column)
            {
                GridCell cell = MakeCell(
                                         originCell.column + column,
                                         originCell.row - row + [lines count] - 1);
                
                unichar ch = [line characterAtIndex: column];
                if (ch == '.')
                    continue;
                else
                if (ch == 'd')
                    [self.grid put: Diamond at: cell];
                else
                if (ch == 'r')
                    [self.grid put: Ruby at: cell];                
                
            }
            
            ++row;
        }
    }
}

- (void) parseGridFrom: (NSString*) string
{
    [self parseGridAt: MakeCell(0, 0) from: string];
}

- (NSString*) description
{
    NSMutableString* content = [NSMutableString stringWithCapacity: self.grid.width * self.grid.height * 2];
    
    for (int row = self.grid.height - 1; row >= 0; --row)
    {
        for (int column = 0; column < self.grid.width; ++column)
        {
            Droppable* droppable = [self.grid get: MakeCell(column, row)];
            if (droppable == nil)
                [content appendString:@"."];
            else
            if ([droppable isKindOfClass: [Gem class]])
            {
                Gem* gem = (Gem*) droppable;
                if ([gem type] == Diamond)
                    [content appendString:@"d"];
                else
                if ([gem type] == Ruby)
                    [content appendString:@"r"];
            }
            else
            if ([droppable isKindOfClass: [BigGem class]])
            {
                BigGem* bigGem = (BigGem*) droppable;
                if ([bigGem type] == Diamond)
                    [content appendString:@"D"];
                else
                if ([bigGem type] == Ruby)
                    [content appendString:@"R"];
            }            
        }
        
        [content appendString: @"\n"];
    }
    
    return [NSString stringWithFormat:@"%@\n%@", [super description], content];    
}

@end