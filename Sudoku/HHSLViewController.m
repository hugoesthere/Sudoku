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
#import "HHSLGridModel.h"

@interface HHSLViewController () {
    UIButton* _buttonSelected;
    HHSLGridView* _gridView;
    HHSLNumPadView* _numPad;
    UIView* _startGame;
    HHSLGridModel* _gridModel;
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
    _gridModel = [HHSLGridModel alloc];
    NSMutableArray* initialGrid = _gridModel.generateGrid;
    _gridView = [[HHSLGridView alloc] initWithFrame:gridFrame andArray:initialGrid];
    _gridView.customDelegate = self;
    [self.view addSubview:_gridView];
    
    // Create number pad
    CGFloat numPadX = gridX;
    CGFloat numPadY = gridY + gridSize + CGRectGetHeight(frame)*.025;
    CGFloat numPadWidth = gridSize;
    CGFloat numPadHeight = CGRectGetHeight(frame)*.15;
    CGRect numPadFrame = CGRectMake(numPadX, numPadY, numPadWidth, numPadHeight);
    
    // Instantiate _numPad and add it to the ViewController
    _numPad = [[HHSLNumPadView alloc] initWithFrame:numPadFrame];
    _numPad.customNumDelegate = self;
    _numSelected = 5;
    [self.view addSubview:_numPad];
    
    // Create new game button
    CGFloat newGameX = CGRectGetWidth(frame)*.33;
    CGFloat newGameY = numPadY + numPadHeight + CGRectGetHeight(frame)*.025;
    CGFloat newGameWidth = gridSize * .33;
    CGFloat newGameHeight = CGRectGetHeight(frame)*.10;
    CGRect newGameFrame = CGRectMake(newGameX, newGameY, newGameWidth, newGameHeight);
    
    _startGame = [[UIView alloc] initWithFrame:newGameFrame];
    _startGame.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_startGame];
    
}

// When a grid cell is pressed, change the button's value to the number displayed
// on the number pad. If the value currently displayed is inconsistent, do nothing.
- (void)buttonPressed:(HHSLGridView *)controller sender:(id)sender {
    int row = [sender tag]%10;
    int col = [sender tag]/10;

    _buttonSelected = (UIButton*)sender;
    
    // Check consistency
    if ([_gridModel isConsistentAtRow:row andColumn:col for:_numSelected]) {
        [_gridView setCellValueGridView:row :col :_numSelected];
        [_gridModel setValueAtRow:row andColumn:col to:_numSelected];
    }
}

// Delegate Function: Set the global variable _numSelected to the number displayed
// on the number pad
- (void)numberSelected:(HHSLNumPadView *)controller number:(int)num {
    _numSelected = num;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
