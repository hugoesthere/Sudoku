//
//  HHSLGridModel.m
//  Sudoku
//
//  Created by Hugo Ho on 9/19/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//
#include <stdlib.h>
#import "HHSLGridModel.h"

@implementation HHSLGridModel


NSMutableArray* _nsGrid;
NSMutableArray* _initialNSGrid;

// Generates the grid numbers by randomly selecting a line from either file
- (NSMutableArray *)generateGrid {
    // Picks a file
    int chooseGridFile = arc4random_uniform(2);
    int numGrids;
    
    NSString* fileName;
    
    if (chooseGridFile == 0) {
        fileName = @"grid1";
        numGrids = 30000;       // Number of lines in grid1.txt
    } else {
        fileName = @"grid2";
        numGrids = 30001;       // Number of lines in grid2.txt
    }
    
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSError* error;
    NSString* readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    // Picks a line from the file
    int chooseGrid = arc4random_uniform(numGrids);
    NSString *gridString = [[readString componentsSeparatedByString:@"\n"] objectAtIndex:chooseGrid];
    
    // Creates _nsGrid to hold the numbers in the grid
    _nsGrid = [[NSMutableArray alloc] initWithCapacity:9];
    for (int i = 0; i < 9; ++i) {
        NSMutableArray* cellsInColumn = [[NSMutableArray alloc] initWithCapacity:9];
        [_nsGrid insertObject:cellsInColumn atIndex:i];
    }
    
    // Fill the _nsGrid with values
    NSUInteger charIndex = 0;
    for (int i = 0; i < 9; i++) {
        for(int j = 0; j < 9; j++) {
            int num = [[gridString substringWithRange:NSMakeRange(charIndex, 1)] intValue];
            NSNumber* nsNum = [NSNumber numberWithInt:num];
            [[_nsGrid objectAtIndex:i] insertObject:nsNum atIndex:j];
            charIndex++;
        }
    }
    
    // Set _initialNSGrid to keep track of the initial values of the grid
    _initialNSGrid = _nsGrid;
    return _nsGrid;
}

// Gets the initial values are a given row and column
- (int)getValueatRow: (int)row andColumn:(int)column
{
    return [[[_nsGrid objectAtIndex:column] objectAtIndex:row] intValue];
}


// Sets value at a given row and column in the _nsGrid property
- (void)setValueAtRow: (int)row andColumn:(int)column to:(int)value
{
    NSNumber* numToInput = [NSNumber numberWithInt:value];
    [[_nsGrid objectAtIndex:column] replaceObjectAtIndex:row withObject:numToInput];
}

// Checks whether the cell at a given row and column is mutable based
// off the initialGrid
- (bool)isMutableatRow: (int)row andColumn:(int)column
{
    return ([[[_initialNSGrid objectAtIndex:column] objectAtIndex:row] intValue] == 0);
}

// Checks if the value is consistent at a given row and column
- (bool)isConsistentAtRow: (int)row andColumn:(int)column for:(int)value
{
    // For row
    for (int i = 0; i < 9; i++) {
        NSNumber* nsCellValue = [[_nsGrid objectAtIndex:column] objectAtIndex:i];
        int cellValue = [nsCellValue intValue];
        if (cellValue == value) {
            return false;
        }
    }
    
    // For column
    for (int i = 0; i < 9; i++) {
        NSNumber* nsCellValue = [[_nsGrid objectAtIndex:i] objectAtIndex:row];
        int cellValue = [nsCellValue intValue];
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
            int cellValue = [nsCellValue intValue];
            if(cellValue == value) {
                return false;
            }
        }
    }
    
    return true;
}

@end
