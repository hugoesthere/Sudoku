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

@interface HHSLViewController () {
    UIButton* _button;
    UIView* _gridView;
    UIView* _numPad;
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
    _gridView = [[HHSLGridView alloc] initWithFrame:gridFrame];
    [self.view addSubview:_gridView];
    
    CGFloat numPadX = gridX;
    CGFloat numPadY = gridY + gridSize + CGRectGetHeight(frame)*.1;
    CGFloat numPadWidth = gridSize;
    CGFloat numPadHeight = CGRectGetHeight(frame)*.15;
    CGRect numPadFrame = CGRectMake(numPadX, numPadY, numPadWidth, numPadHeight);
    
    _numPad = [[HHSLNumPadView alloc] initWithFrame:numPadFrame];
    [self.view addSubview:_numPad];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
