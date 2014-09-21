//
//  HHSLNumPadView.h
//  Sudoku
//
//  Created by Hugo Ho on 9/19/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHSLNumPadView;
@protocol numPadDelegate

-(void)numberSelected:(HHSLNumPadView *)controller number:(int)num;

@end

@interface HHSLNumPadView : UIView

@property(nonatomic, weak) id<numPadDelegate> customNumDelegate;

@end
