//
//  HHSLNumPadView.m
//  Sudoku
//
//  Created by Hugo Ho on 9/19/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import "HHSLNumPadView.h"


@interface HHSLNumPadView () {
    UILabel* _numDisplay;
}

@end

@implementation HHSLNumPadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Set dimensions for number picker display
        CGFloat frameWidth = CGRectGetWidth(frame);
        CGFloat frameHeight = CGRectGetHeight(frame);
        CGFloat numDisplayX = frameWidth * .33;
        CGRect numDisplay = CGRectMake(numDisplayX, 0, numDisplayX, frameHeight);

        // Initialize number picker display
        _numDisplay = [[UILabel alloc] initWithFrame:numDisplay];
        _numDisplay.text = @"5";
        _numDisplay.textAlignment = NSTextAlignmentCenter;
        _numDisplay.font = [UIFont systemFontOfSize:75];
        _numDisplay.layer.borderColor = [UIColor blackColor].CGColor;
        _numDisplay.layer.borderWidth = 3.0;
        [self addSubview:_numDisplay];
        
        // Create left arrow button as a clickable UIImageView
        // Taken from: http://stackoverflow.com/questions/11330544/uiimageview-as-button
        UIImageView* leftArrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, numDisplayX, frameHeight)];
        [leftArrow setImage:[UIImage imageNamed:@"green traingle left.png"]];
        [leftArrow setUserInteractionEnabled:YES];
        UITapGestureRecognizer* singleTapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTappingLeft:)];
        [singleTapLeft setNumberOfTapsRequired:1];
        [leftArrow addGestureRecognizer:singleTapLeft];
        [self addSubview:leftArrow];
        
        // Create right arrow button as a clickable UIImageVIew
        CGFloat rightArrowX = frameWidth * .66;
        UIImageView* rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(rightArrowX, 0, numDisplayX, frameHeight)];
        [rightArrow setImage:[UIImage imageNamed:@"green triangle right.png"]];
        [rightArrow setUserInteractionEnabled:YES];
        UITapGestureRecognizer* singleTapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTappingRight:)];
        [singleTapRight setNumberOfTapsRequired:1];
        [rightArrow addGestureRecognizer:singleTapRight];
        [self addSubview:rightArrow];
        
        
        
    }
    return self;
}

- (void)singleTappingLeft:(UIGestureRecognizer *)recognizer
{
    NSInteger num = [_numDisplay.text integerValue];
    if(num > 1) {
        num--;
    } else {
        num = 9;
    }
    NSString* numStr = [NSString stringWithFormat:@"%d", num];
    _numDisplay.text = numStr;
    [self.customNumDelegate numberSelected:self number: num];
}

- (void)singleTappingRight:(UIGestureRecognizer *)recognizer
{
    NSInteger num = [_numDisplay.text integerValue];
    if(num < 9) {
        num++;
    } else {
        num = 1;
    }
    NSString* numStr = [NSString stringWithFormat:@"%d", num];
    _numDisplay.text = numStr;
    [self.customNumDelegate numberSelected:self number: num];
}

@end
