//
//  ABFrameViewController.h
//  300Pins
//
//  Created by Alex on 12/25/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Frame;

@interface ABFrameViewController : UIViewController

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

#pragma mark - Model Object
@property (nonatomic, strong) Frame *frame;

#pragma mark - IBActions
- (IBAction)pinButtonPressed:(UIButton *)sender;

@end
