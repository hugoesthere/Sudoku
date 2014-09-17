//
//  HHSLViewController.m
//  sudoku
//
//  Created by Hugo Ho on 9/11/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import "HHSLViewController.h"
#import "HHSLGridView.h"

@interface HHSLViewController () {
    UIButton* _button;
    UIView* _gridView;
}

@end

@implementation HHSLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create grid frame
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame)*.1;
    CGFloat y = CGRectGetHeight(frame)*.1;
    CGFloat size = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // Instantiate _gridView and add it to the ViewController
    _gridView = [[HHSLGridView alloc] initWithFrame:gridFrame];
    [self.view addSubview:_gridView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
