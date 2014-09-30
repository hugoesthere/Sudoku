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
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface HHSLViewController () {
    UIButton* _newGameButton;
    UIButton* _validateGameButton;
    HHSLGridView* _gridView;
    HHSLNumPadView* _numPad;
    UIView* _startGame;
    HHSLGridModel* _gridModel;
    int _numSelected;
    CGRect _gridFrame;
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
    _gridFrame = CGRectMake(gridX, gridY, gridSize, gridSize);
    
    // Set background
    UIImageView* background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [background setImage:[UIImage imageNamed:@"green_background.jpg"]];
    [self.view addSubview:background];
    
    // Instantiate _gridView and add it to the ViewController
    _gridModel = [HHSLGridModel alloc];
    NSMutableArray* initialGrid = _gridModel.generateGrid;
    _gridView = [[HHSLGridView alloc] initWithFrame:_gridFrame andArray:initialGrid];
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
    
    // Create new game button
    CGFloat newGameWidth = gridSize * .33;
    CGFloat newGameHeight = CGRectGetHeight(frame)*.05;
    CGFloat newGameX = CGRectGetWidth(frame)*.5 - newGameWidth*.52;
    CGFloat newGameY = numPadY + numPadHeight + CGRectGetHeight(frame)*.01;
    
    // Instantiate _newGameButton and add it to the View Controller
    CGRect newGameButtonFrame = CGRectMake(newGameX, newGameY, newGameWidth, newGameHeight);
    _newGameButton = [[UIButton alloc] initWithFrame:newGameButtonFrame];
    [_newGameButton setImage:[UIImage imageNamed:@"start over 2.png"] forState:UIControlStateNormal];
    [_newGameButton addTarget:self action:@selector(startNewGame) forControlEvents:UIControlEventTouchUpInside];
    
    // Create validate game button
    CGFloat validateGameX = CGRectGetWidth(frame)*.5 - newGameWidth*.52;
    CGFloat validateGameY = numPadY + numPadHeight + + newGameHeight + CGRectGetHeight(frame)*.015;
    
    // Instantiate _validateGameButton
    CGRect validateGameButtonFrame = CGRectMake(validateGameX, validateGameY, newGameWidth, newGameHeight);
    _validateGameButton = [[UIButton alloc] initWithFrame:validateGameButtonFrame];
    [_validateGameButton setImage:[UIImage imageNamed:@"validate game.png"] forState:UIControlStateNormal];
    [_validateGameButton addTarget:self action:@selector(validateGame) forControlEvents:UIControlEventTouchUpInside];
}

// When a grid cell is pressed, change the button's value to the number displayed
// on the number pad. If the value currently displayed is inconsistent, do nothing.
- (void)buttonPressed:(HHSLGridView *)controller sender:(id)sender {
    [self.view addSubview:_numPad];
    [self.view addSubview:_newGameButton];
    [self.view addSubview:_validateGameButton];
    
    // Extract appropriate information from the sender tag
    int row = (int)[sender tag]%10;
    int col = (int)[sender tag]/10;
    
    // If _numSelected is 0, set the value to 0. Otherwise, check for consistency before
    // setting
    if (_numSelected == 0) {
        [_gridView setCellValueGridView:row :col :0];
        [_gridModel setValueAtRow:row andColumn:col to:0];
    } else if ([_gridModel isConsistentAtRow:row andColumn:col for:_numSelected]) {
        [_gridView setCellValueGridView:row :col :_numSelected];
        [_gridModel setValueAtRow:row andColumn:col to:_numSelected];
    }


}

// Delegate Function: Set the global variable _numSelected to the number displayed
// on the number pad
- (void)numberSelected:(HHSLNumPadView *)controller number:(int)num {
    _numSelected = num;
}

// Starts new game by generating new numbers
- (void)startNewGame {
    [self playClickfor:0];
    NSMutableArray* initialGrid = _gridModel.generateGrid;
    _gridView = [[HHSLGridView alloc] initWithFrame:_gridFrame andArray:initialGrid];
    _gridView.customDelegate = self;
    [self.view addSubview:_gridView];
}

// Validates game
// UIAlert reports result
- (void)validateGame {
    bool won = true;
    // Checks through current numbers to see if
    // any are 0. If none of them are 0, the current answer
    // is correct.
    for (int i = 0; i < 9; i++) {
        for(int j = 0; j < 9; j++) {
            if([_gridModel getValueatRow:i andColumn:j] == 0){
                won = false;
                break;
            }
        }
    }
    
    // Creates settings for UIAlert pop-up
    NSString* title = @"Result";
    NSString* message;
    if(won) {
        message = @"You won!";
    } else {
        message = @"You tried... (and lost)";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [self playClickfor:1];
    [alertView show];
}

// Plays the appropriate sound depending on which button was clicked
- (void)playClickfor:(int)startOrValidate
{
    // Start button selected = 0
    // Validate button selected = 1
    NSString* fileName;
    if (startOrValidate == 0) {
        fileName = @"StartOverSfx";
    } else {
        fileName = @"HmmSfx";
    }
    
    // Uses AVAudioPlayer to play the appropriate wav file
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    
    self.player = newPlayer;
    [self.player play];
}

// Creates UIImage to display on highlight
// Method from:
// stackoverflow.com/questions/990976/how-to-create-a-colored-1x1-uiimage-on-the-iphone-dynamically
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 50 , 50);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
