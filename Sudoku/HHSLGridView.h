//
//  HHSLGridView.h
//  Sudoku
//
//  Created by Hugo Ho on 9/17/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHSLGridView;
@protocol gridDelegate

-(void)buttonPressed:(HHSLGridView *)controller sender:(id)sender;
//-(void)buttonNotPressed:(HHSLGridView *)controller sender:(id)sender;

@end

@interface HHSLGridView : UIView

@property(nonatomic, weak) id<gridDelegate> customDelegate;
-(void)setCellValueGridView: (int)row :(int)column :(int)newValue;

@end
