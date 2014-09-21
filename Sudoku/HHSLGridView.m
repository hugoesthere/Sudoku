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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        CGFloat size = CGRectGetWidth(frame);
        CGFloat buttonSize = size/11.0;
        
        _arrayOfCells = [[NSMutableArray alloc] initWithCapacity:9];
        
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
                [button setEnabled:YES];
                button.backgroundColor = [UIColor whiteColor];
                button.tag = row + 10*column;
                [self addSubview:button];
                
                // Highlight cell when clicked
                [button addTarget:self action:@selector(cellPressed:) forControlEvents:UIControlEventTouchUpInside];
                //[button addTarget:self action:@selector(cellNotPressed:) forControlEvents:UIControlEventTouchDownRepeat];
                [button setBackgroundImage:[self imageWithColor: [UIColor yellowColor]] forState:UIControlStateHighlighted];
                
                // Create cell title, which displays value of cell
                //int cellValue = initialGrid[column][row];
                NSString *label = @"";
                //if (cellValue != 0) {
                //    label = [NSString stringWithFormat:@"%d", cellValue];
                //    [button setEnabled:NO];
                    
                //}
                
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

-(void)setCellValueGridView: (int)row :(int)column :(int)newValue
{
    UIButton* selectedButton = [[_arrayOfCells objectAtIndex:column] objectAtIndex:row];
    NSString* label = [NSString stringWithFormat:@"%d", newValue];
    [selectedButton setTitle:label forState:UIControlStateNormal];
    [selectedButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

-(void)cellPressed: (id)sender
{
    [self.customDelegate buttonPressed:self sender:sender];
}

//-(void)cellNotPressed: (id)sender
//{
//    [self.customDelegate buttonNotPressed:self sender:sender];
//}

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
