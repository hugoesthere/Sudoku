//
//  HHSLViewController.h
//  Sudoku
//
//  Created by Hugo Ho on 9/17/14.
//  Copyright (c) 2014 Hugo Ho and Shannon Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHSLGridView.h"
#import "HHSLNumPadView.h"
#import <AudioToolbox/AudioToolbox.h>


@interface HHSLViewController : UIViewController <gridDelegate, numPadDelegate>

@property (nonatomic, retain) AVAudioPlayer *player;

@end



