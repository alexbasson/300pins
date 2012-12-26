//
//  ABFrameViewController.m
//  300Pins
//
//  Created by Alex on 12/25/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import "ABFrameViewController.h"
#import "Frame.h"
#import "Game.h"

@interface ABFrameViewController ()
@property (nonatomic, strong) NSMutableSet *firstBallPins;
@property (nonatomic, strong) NSMutableSet *secondBallPins;
@property (nonatomic, strong, readonly) Game *game;
@end

@implementation ABFrameViewController

@synthesize game = _game;

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

- (Game *)game
{
    if (!_game) {
        _game = [[self frame] game];
    }
    return _game;
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

#pragma mark - ABScoreViewDelegate Methods

- (NSString *)firstBallForFrameNumber:(NSInteger)frameNumber
{
    return @"0";
//    Frame *frame = [[self game] frames][frameNumber];
//    NSString *mark;
//    if ([frame isStrike]) {
//        mark = @"X";
//    } else {
//        mark = [NSString stringWithFormat:@"%i", [frame firstBall]];
//    }
//    return mark;
}

- (NSString *)secondBallForFrameNumber:(NSInteger)frameNumber
{
    Frame *frame = [[self game] frames][frameNumber];
    NSString *mark;
    if ([frame isSpare]) {
        mark = @"/";
    } else {
        mark = [NSString stringWithFormat:@"%i", [frame secondBall]];
    }
    return mark;
}

- (NSString *)thirdBall
{
    Frame *frame = [[self game] frames][10];
    NSString *mark;
    if ([frame thirdBall] == 10) {
        mark = @"X";
    } else {
        mark = [NSString stringWithFormat:@"%i", [frame thirdBall]];
    }
    return mark;
}

- (NSString *)scoreForFrameNumber:(NSInteger)frameNumber
{
    Frame *frame = [[self game] frames][frameNumber];
#pragma unused (frame) // Will use frame to implement "don't mark score while striking".
    NSString *mark;
    mark = [NSString stringWithFormat:@"%i", [[self game] scoreForFrameNumber:frameNumber]];
    return mark;
}

@end
