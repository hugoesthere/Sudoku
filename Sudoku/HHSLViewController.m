//
//  HHSLViewController.m
//  sudoku
//
//  Created by Hugo Ho on 9/11/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import "HHSLViewController.h"
#import "HHSLGridView.h"
#import "HHSLNumPadView.h"
//#import "HHSLGridModel.h"

@interface HHSLViewController () {
    UIButton* _button;
    HHSLGridView* _gridView;
    HHSLNumPadView* _numPad;
   // HHSLGridModel* _gridModel;
    int _numSelected;
}

@end

@implementation HHSLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create grid frame
    CGRect frame = self.view.frame;
    CGFloat gridX = CGRectGetWidth(frame)*.1;
    CGFloat gridY = CGRectGetHeight(frame)*.1;
    CGFloat gridSize = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    CGRect gridFrame = CGRectMake(gridX, gridY, gridSize, gridSize);
    
    // Instantiate _gridView and add it to the ViewController
    //_gridModel = [HHSLGridModel alloc];
    _gridView = [[HHSLGridView alloc] initWithFrame:gridFrame];
    _gridView.customDelegate = self;
    [self.view addSubview:_gridView];
    
    // Create num pad
    CGFloat numPadX = gridX;
    CGFloat numPadY = gridY + gridSize + CGRectGetHeight(frame)*.1;
    CGFloat numPadWidth = gridSize;
    CGFloat numPadHeight = CGRectGetHeight(frame)*.15;
    CGRect numPadFrame = CGRectMake(numPadX, numPadY, numPadWidth, numPadHeight);
    
    // Instantiate _numPad and add it to the ViewController
    _numPad = [[HHSLNumPadView alloc] initWithFrame:numPadFrame];
    _numPad.customNumDelegate = self;
    _numSelected = 5;
}

- (void) buttonPressed:(HHSLGridView *)controller sender:(id)sender {
    int row = [sender tag]%10;
    int col = [sender tag]/10;
    NSLog(@"Button in Column %d and Row %d was pressed with num %d", col, row, _numSelected);
    [self.view addSubview:_numPad];
    [_gridView setCellValueGridView:row :col :_numSelected];
}

//- (void) buttonNotPressed:(HHSLGridView *)controller sender:(id)sender {
//    [_numPad removeFromSuperview];
//}

- (void) numberSelected:(HHSLNumPadView *)controller number:(int)num {
    _numSelected = num;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
