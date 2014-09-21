//
//  HHSLGridModel.m
//  Sudoku
//
//  Created by Hugo Ho on 9/19/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import "HHSLGridModel.h"

@implementation HHSLGridModel

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

- (int)getValueatRow: (int)row andColumn:(int)column
{
    return initialGrid[column][row];
}

- (void)setValueatRow: (int)row andColumn:(int)column to:(int)value
{
    initialGrid[column][row] = value;
}

- (bool)isMutableatRow: (int)row andColumn:(int)column
{
    return (initialGrid[column][row] == 0);
}

- (bool)isConsistentAtRow: (int)row andColumn:(int)column for:(int)value
{
    // For row
    for (int i = 0; i < 9; i++) {
        if (initialGrid[column][i] == value) {
            return false;
        }
    }
    // For column
    for (int i = 0; i < 9; i++) {
        if (initialGrid[i][row] == value) {
            return false;
        }
    }
    // For subgrid
    int leftCol = (column/3)*3;
    int rightCol = leftCol + 2;
    int upperRow = (row/3)*3;
    int lowerRow = upperRow + 2;
    for(int i = leftCol; i <= rightCol; i++) {
        for(int j = upperRow; j <= lowerRow; j++) {
            if(initialGrid[i][j] == value) {
                return false;
            }
        }
    }
    
    return true;
}

@end
