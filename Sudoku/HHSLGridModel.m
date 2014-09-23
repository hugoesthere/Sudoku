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

NSMutableArray* _nsGrid;

// Gets the initial values are a given row and column
- (int)getValueatRow: (int)row andColumn:(int)column
{
    return initialGrid[column][row];
}

// Creates an NSMutableArray from provided static 2D array
- (NSMutableArray *)getInitialArray {
    
    // Create the skeleton for the NSMutableArray of NSMutableArrays
    NSMutableArray* mutableInitialGrid = [[NSMutableArray alloc] initWithCapacity:9];
    for (int i = 0; i < 9; ++i) {
        NSMutableArray* cellsInColumn = [[NSMutableArray alloc] initWithCapacity:9];
        [mutableInitialGrid insertObject:cellsInColumn atIndex:i];
    }
    
    // Fill in the values from the static 2D array
    for (int i = 0; i < 9; i++) {
        for(int j = 0; j < 9; j++) {
            NSNumber* num = [NSNumber numberWithInt:initialGrid[j][i]];
            [[mutableInitialGrid objectAtIndex:i] insertObject:num atIndex:j];
        }
    }
    
    _nsGrid = mutableInitialGrid;
    return mutableInitialGrid;
}

// Sets value at a given row and column in the _nsGrid property
- (void)setValueAtRow: (int)row andColumn:(int)column to:(int)value
{
    NSNumber* numToInput = [NSNumber numberWithInt:value];
    [[_nsGrid objectAtIndex:column] insertObject:numToInput atIndex:row];
}

// Checks whether the cell at a given row and column is mutable based
// off the initialGrid
- (bool)isMutableatRow: (int)row andColumn:(int)column
{
    return (initialGrid[column][row] == 0);
}

// Checks if the value is consistent at a given row and column
- (bool)isConsistentAtRow: (int)row andColumn:(int)column for:(int)value
{
    // For row
    for (int i = 0; i < 9; i++) {
        NSNumber* nsCellValue = [[_nsGrid objectAtIndex:column] objectAtIndex:i];
        int cellValue = [nsCellValue integerValue];
        if (cellValue == value) {
            return false;
        }
    }
    
    // For column
    for (int i = 0; i < 9; i++) {
        NSNumber* nsCellValue = [[_nsGrid objectAtIndex:i] objectAtIndex:row];
        int cellValue = [nsCellValue integerValue];
        if (cellValue == value) {
            return false;
        }
    }
    
    // For 3x3 sub-grid
    int leftCol = (column/3)*3;
    int rightCol = leftCol + 2;
    int upperRow = (row/3)*3;
    int lowerRow = upperRow + 2;
    for(int i = leftCol; i <= rightCol; i++) {
        for(int j = upperRow; j <= lowerRow; j++) {
            NSNumber* nsCellValue = [[_nsGrid objectAtIndex:i] objectAtIndex:j];
            int cellValue = [nsCellValue integerValue];
            if(cellValue == value) {
                return false;
            }
        }
    }
    
    return true;
}

@end
