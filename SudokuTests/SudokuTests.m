//
//  SudokuTests.m
//  SudokuTests
//
//  Created by Hugo Ho on 9/17/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import "HHSLViewController.h"
#import "HHSLNumPadView.h"
#import "HHSLGridView.h"
#import "HHSLGridModel.h"
#import <XCTest/XCTest.h>

@interface SudokuTests : XCTestCase {
    HHSLGridView* _gridView;
    HHSLNumPadView* _numPad;
    HHSLGridModel* _gridModel;
}
@end

@implementation SudokuTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    _numPad = [[HHSLNumPadView alloc] init];
    _gridView = [[HHSLGridView alloc] init];
    _gridModel = [[HHSLGridModel alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)gridTest
{
    NSMutableArray *currentGrid = _gridModel.generateGrid;
    
    // Checks getValueatRowandColumn
    NSNumber* nsCellValue1 = [[currentGrid objectAtIndex:3] objectAtIndex:5];
    int cellValue1 = [nsCellValue1 intValue];
    XCTAssertEqual([_gridModel getValueatRow:3 andColumn:5], cellValue1, @"They are equal");
    
    NSNumber* nsCellValue2 = [[currentGrid objectAtIndex:3] objectAtIndex:5];
    int cellValue2 = [nsCellValue2 intValue];
    XCTAssertEqual([_gridModel getValueatRow:3 andColumn:5], cellValue2, @"They are equal");
    
    NSNumber* nsCellValue3 = [[currentGrid objectAtIndex:6] objectAtIndex:1];
    int cellValue3 = [nsCellValue3 intValue];
    XCTAssertEqual([_gridModel getValueatRow:6 andColumn:1], cellValue3, @"They are equal");
    
    // Checks isConsistentAtRowandColumn
    XCTAssertFalse([_gridModel isConsistentAtRow:8 andColumn:8 for:4], @"It is false");
    XCTAssertTrue([_gridModel isConsistentAtRow:7 andColumn:4 for:5], @"It is true");
    XCTAssertFalse([_gridModel isConsistentAtRow:0 andColumn:2 for:2], @"It is false");
    
    // Checks setValueAtRowandColumn
    [_gridModel setValueAtRow:7 andColumn:7 to:5];
    XCTAssertEqual([_gridModel getValueatRow:7 andColumn:7], 5, @"It was set correctly");
    
    [_gridModel setValueAtRow:1 andColumn:1 to:3];
    XCTAssertEqual([_gridModel getValueatRow:1 andColumn:1], 3, @"It was set correctly");
    
    [_gridModel setValueAtRow:7 andColumn:1 to:6];
    XCTAssertEqual([_gridModel getValueatRow:7 andColumn:1], 6, @"It was set correctly");
}
@end
