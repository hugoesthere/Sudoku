//
//  HHSLNumPadView.h
//  Sudoku
//
//  Created by Hugo Ho on 9/19/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

// Create a delegate to send information from the number pad to the
// controller
@class HHSLNumPadView;
@protocol numPadDelegate

- (void)numberSelected:(HHSLNumPadView *)controller number:(int)num;

@end

@interface HHSLNumPadView : UIView

@property (nonatomic, retain) AVAudioPlayer *player;
@property(nonatomic, weak) id<numPadDelegate> customNumDelegate;

@end
