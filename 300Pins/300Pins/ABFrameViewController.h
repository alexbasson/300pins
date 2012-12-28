//
//  ABFrameViewController.h
//  300Pins
//
//  Created by Alex on 12/25/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABScoreView.h"
@class Frame;

@interface ABFrameViewController : UIViewController <ABScoreViewDelegate>

#pragma mark - UI Elements
@property (nonatomic, weak) IBOutlet UIButton *pin01Button;
@property (nonatomic, weak) IBOutlet UIButton *pin02Button;
@property (nonatomic, weak) IBOutlet UIButton *pin03Button;
@property (nonatomic, weak) IBOutlet UIButton *pin04Button;
@property (nonatomic, weak) IBOutlet UIButton *pin05Button;
@property (nonatomic, weak) IBOutlet UIButton *pin06Button;
@property (nonatomic, weak) IBOutlet UIButton *pin07Button;
@property (nonatomic, weak) IBOutlet UIButton *pin08Button;
@property (nonatomic, weak) IBOutlet UIButton *pin09Button;
@property (nonatomic, weak) IBOutlet UIButton *pin10Button;

@property (nonatomic, weak) IBOutlet ABScoreView *scoreView;
@property (nonatomic, weak) IBOutlet UILabel *ballNumberLabel;
@property (nonatomic, weak) IBOutlet UIImageView *bowlingBallButton;
@property (nonatomic, weak) IBOutlet UIButton *recordBallButton;

#pragma mark - Initializer
- (id)initWithFrameNumber:(NSInteger)frameNumber;

#pragma mark - Model Objects
@property (nonatomic, strong) Frame *frame;
@property (nonatomic) NSInteger frameNumber;

#pragma mark - IBActions
- (IBAction)pinButtonPressed:(UIButton *)sender;
- (IBAction)recordBallButtonPressed:(UIButton *)sender;

@end
