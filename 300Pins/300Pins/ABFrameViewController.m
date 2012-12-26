//
//  ABFrameViewController.m
//  300Pins
//
//  Created by Alex on 12/25/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import "ABFrameViewController.h"

@interface ABFrameViewController ()
@property (nonatomic, strong) NSMutableSet *firstBallPins;
@property (nonatomic, strong) NSMutableSet *secondBallPins;
@end

@implementation ABFrameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _firstBallPins = [NSMutableSet setWithCapacity:10];
        _secondBallPins = [NSMutableSet setWithCapacity:10];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pinButtonPressed:(UIButton *)sender
{
    NSNumber *pinNumber = @([sender tag]-100);
    NSString *buttonNumber = [[@([sender tag]) stringValue] substringFromIndex:1];
    UIImage *uprightPinImage = [UIImage imageNamed:[buttonNumber stringByAppendingString:@"pinUpright"]];
    UIImage *fallenPinImage = [UIImage imageNamed:[buttonNumber stringByAppendingString:@"pinFallen"]];
    if ([_firstBallPins containsObject:pinNumber]) {
        [sender setImage:uprightPinImage forState:UIControlStateNormal];
        [_firstBallPins removeObject:pinNumber];
    } else {
        [sender setImage:fallenPinImage forState:UIControlStateNormal];
        [_firstBallPins addObject:pinNumber];
    }
    NSLog(@"Button tag: %@", buttonNumber);
    NSLog(@"_firstBallPins: %@", _firstBallPins);
}

@end
