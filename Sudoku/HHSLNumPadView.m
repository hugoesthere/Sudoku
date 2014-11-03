//
//  HHSLNumPadView.m
//  Sudoku
//
//  Created by Hugo Ho on 9/19/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import "HHSLNumPadView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


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
        CGFloat frameWidth = CGRectGetWidth(frame)*.9;
        CGFloat frameHeight = CGRectGetHeight(frame);
        CGFloat numDisplayX = frameWidth * .4;
        CGRect numDisplay = CGRectMake(numDisplayX, 0, numDisplayX, frameHeight);

        // Initialize number picker display
        _numDisplay = [[UILabel alloc] initWithFrame:numDisplay];
        _numDisplay.backgroundColor = [UIColor whiteColor];
        _numDisplay.text = @"5";            // Default number picker value
        UIImage *image = [UIImage imageNamed:@"5.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [_numDisplay addSubview:imageView];
        [self addSubview:_numDisplay];
        
        // Create left arrow button as a clickable UIImageView
        // Taken from: http://stackoverflow.com/questions/11330544/uiimageview-as-button
        UIImageView* leftArrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, numDisplayX, frameHeight)];
        [leftArrow setImage:[UIImage imageNamed:@"paint left arrow.png"]];
        [leftArrow setUserInteractionEnabled:YES];
        UITapGestureRecognizer* singleTapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTappingLeft:)];
        [singleTapLeft setNumberOfTapsRequired:1];
        [leftArrow addGestureRecognizer:singleTapLeft];
        [self addSubview:leftArrow];
        
        // Create right arrow button as a clickable UIImageVIew
        CGFloat rightArrowX = frameWidth * .66;
        UIImageView* rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(rightArrowX, 0, numDisplayX, frameHeight)];
        [rightArrow setImage:[UIImage imageNamed:@"paint right arrow.png"]];
        [rightArrow setUserInteractionEnabled:YES];
        UITapGestureRecognizer* singleTapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTappingRight:)];
        [singleTapRight setNumberOfTapsRequired:1];
        [rightArrow addGestureRecognizer:singleTapRight];
        [self addSubview:rightArrow];
    }
    
    return self;
}

// Creates the sliding animation for the number pad
- (void)numPadAnimation:(UILabel*)numLabel from:(int)leftOrRight;
{
    
    CATransition* animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.type = kCATransitionMoveIn;
    
    // If left arrow is selected, use transition from right
    // Otherwise, use transition from left
    if(leftOrRight == 0) {
        animation.subtype = kCATransitionFromRight;
    } else {
        animation.subtype = kCATransitionFromLeft;
    }
    
    animation.duration = 0.5;
    [numLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    
    
}

// Taken from: http://stackoverflow.com/questions/11525942/play-audio-ios-objective-c
- (void)playClickfor:(int)leftOrRight
{
    // Selects the appropriate file depending on which arrow was clicked
    // Left is 0. Right otherwise
    NSString* fileName;
    if (leftOrRight == 0) {
        fileName = @"LeftClickSfx";
    } else {
        fileName = @"ClickRightSfx";
        
    }
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    
    self.player = newPlayer;
    [self.player play];
}

// If the left button is tapped, decrement the value displayed.
// The numbers wrap around. Send the value displayed to the
// ViewController via delegate.
- (void)singleTappingLeft:(UIGestureRecognizer *)recognizer
{
    NSInteger num = [_numDisplay.text integerValue];
    
    if(num > 0) {
        num--;
    } else {
        num = 9;
    }
    
    // Used to select the desired file name
    NSString* imageName = [NSString stringWithFormat:@"%ld.png",(long)num];
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    // Triggers effects (sound and animation).
    // Also calls on delegate class's function to send information to ViewController
    NSString* numStr = [@(num) stringValue];
    [self numPadAnimation:_numDisplay from:0];
    [self playClickfor:0];
    [_numDisplay addSubview:imageView];
    _numDisplay.text = numStr;
    [self.customNumDelegate numberSelected:self number: (int)num];
}

// If the right button is tapped, increment the value displayed.
// The numbers wrap around. Send the value displayed to the
// ViewController via delegate.
- (void)singleTappingRight:(UIGestureRecognizer *)recognizer
{
    NSInteger num = [_numDisplay.text integerValue];
    
    if(num < 9) {
        num++;
    } else {
        num = 0;
    }
    
    // Used to select the desired file name
    NSString* imageName = [NSString stringWithFormat:@"%ld.png",(long)num];

    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    // Triggers effects (sound and animation).
    // Also calls on delegate class's function to send information to ViewController
    NSString* numStr = [@(num) stringValue];
    [self numPadAnimation:_numDisplay from:1];
    [self playClickfor:1];
    [_numDisplay addSubview:imageView];
    _numDisplay.text = numStr;
    [self.customNumDelegate numberSelected:self number: (int)num];
}

@end
