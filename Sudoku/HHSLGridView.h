//
//  HHSLGridView.h
//  Sudoku
//
//  Created by Hugo Ho on 9/17/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

// Delegate to send information to the ViewController
@class HHSLGridView;
@protocol gridDelegate

- (void)buttonPressed:(HHSLGridView *)controller sender:(id)sender;

@end

@interface HHSLGridView : UIView

@property (nonatomic, retain) AVAudioPlayer *player;

@property(nonatomic, weak) id<gridDelegate> customDelegate;
- (void)setCellValueGridView: (int)row :(int)column :(int)newValue;
- (id)initWithFrame:(CGRect)frame andArray:(NSMutableArray *)initialGrid;



@end
