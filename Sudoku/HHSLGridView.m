//
//  HHDDGridView.m
//  sudoku
//
//  Created by Hugo Ho on 9/11/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import "HHSLGridView.h"

@interface HHSLGridView () {
    NSMutableArray *_arrayOfCells;
}

@end

@implementation HHSLGridView

int initialGrid[9][9] = {
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}
};

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        CGFloat size = CGRectGetWidth(frame);
        CGFloat buttonSize = size/11.0;
        
        // Array for sudoku cells
        for (int i = 0; i < 9; ++i) {
            NSMutableArray* cellsInColumn = [[NSMutableArray alloc] initWithCapacity:9];
            [_arrayOfCells insertObject:cellsInColumn atIndex:i];
        }
        
        for (int column = 0; column < 9; ++column) {
            for (int row = 0; row < 9; ++row) {
                // Create dimensions of each cell
                int yBigspace = (row / 3) * (size / 50.0);      // Extra space to denote sub (3x3) grid
                int xBigspace = (column / 3) * (size / 50.0);   // Extra space to denote sub (3x3) grid
                int framePadding = (size / 25.0);
                int cellSize = (buttonSize + (size / 122.0));   // Includes spacing between cells
                int x = (column) * cellSize + framePadding + xBigspace;
                int y = (row) * cellSize + framePadding + yBigspace;
                
                // Initializing button & cell (which is a button) UI
                CGRect buttonFrame = CGRectMake(x,y, buttonSize, buttonSize);
                UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
                button.backgroundColor = [UIColor whiteColor];
                button.tag = row + 10*column;
                [self addSubview:button];
                
                // Highlight cell when clicked
                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundImage:[self imageWithColor: [UIColor yellowColor]] forState:UIControlStateHighlighted];
                
                // Create cell title, which displays value of cell
                int cellValue = initialGrid[column][row];
                NSString *label = @"";
                if (cellValue != 0) {
                    label = [NSString stringWithFormat:@"%d", cellValue];
                }
                
                // UI for cell titles
                [button setTitle:label forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                
                // Adding button to _arrOfColumns
                [[_arrayOfCells objectAtIndex:column] insertObject:button atIndex:row];
            }

        }
        
    }
    return self;
}

- (void)buttonPressed:(id)sender
{
    int row = [sender tag]%10;
    int col = [sender tag]/10;
    NSLog(@"Button in Column %d and Row %d was pressed", col, row);
}

// Method from:
// stackoverflow.com/questions/990976/how-to-create-a-colored-1x1-uiimage-on-the-iphone-dynamically
// Creates UIImage to display on highlight
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 50 , 50);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
