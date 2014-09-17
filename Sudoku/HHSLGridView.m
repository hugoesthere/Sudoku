//
//  HHDDGridView.m
//  sudoku
//
//  Created by Hugo Ho on 9/11/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import "HHSLGridView.h"

@interface HHSLGridView () {
    NSMutableArray *_arrOfColumns;
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
        
        NSLog(@"size: %f", size);
        
        CGFloat buttonSize = size/11.0;
        
        // Change this!
        for (int column = 0; column < 9; ++column) {
            NSMutableArray* cellsInColumn;
            for (int row = 0; row < 9; ++row) {
                int y_bigspace = (row / 3) * (size / 50.0);
                int x_bigspace = (column / 3) * (size / 50.0);
                int x = (size / 25.0) + (column) * (buttonSize + (size / 122.0)) + x_bigspace;
                int y = (size / 25.0) + (row) * (buttonSize + (size/ 122.0)) + y_bigspace;
                CGRect buttonFrame = CGRectMake(x,y, buttonSize, buttonSize);
                UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
                button.backgroundColor = [UIColor whiteColor];
                button.tag = row + 10*column;
                [self addSubview:button];
                
                [button addTarget:self action:@selector(highlightButton:) forControlEvents:UIControlEventTouchDown];
                [button addTarget:self action:@selector(resetButton:) forControlEvents:UIControlEventTouchUpInside];
                [button addTarget:self action:@selector(resetButton:) forControlEvents:UIControlEventTouchUpOutside];
                
                //create target for button
                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                int cellNumber = initialGrid[column][row];
                NSString *label;
                if(cellNumber == 0)
                    label = @"";
                else
                    label = [NSString stringWithFormat:@"%d", cellNumber];
                
                [button setTitle:label forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                
                [cellsInColumn insertObject:button atIndex:row];
            }
            
            [_arrOfColumns insertObject:cellsInColumn atIndex:column];
        }
        
    }
    return self;
}

- (void)buttonPressed: (id)sender
{
    UIButton* button = (UIButton*)sender;
    NSLog([NSString stringWithFormat:@"Row: %d Column %d", button.tag % 10, button.tag / 10]);
}

- (void)highlightButton: (id)sender
{
    UIButton* button = (UIButton*)sender;
    [button setBackgroundColor:[UIColor yellowColor]];
}

- (void)resetButton: (id)sender
{
    UIButton* button = (UIButton*)sender;
    [button setBackgroundColor:[UIColor whiteColor]];
}

@end
