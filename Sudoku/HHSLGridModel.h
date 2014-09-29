//
//  HHSLGridModel.h
//  Sudoku
//
//  Created by Hugo Ho on 9/19/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHSLGridModel : NSObject

- (int)getValueatRow: (int)row andColumn:(int)column;
- (NSMutableArray *)generateGrid;
- (bool)isConsistentAtRow: (int)row andColumn:(int)column for:(int)value;
- (void)setValueAtRow: (int)row andColumn:(int)column to:(int)value;

@end
