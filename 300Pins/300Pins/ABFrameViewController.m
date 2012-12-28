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

typedef enum {
    FIRSTBALL = 0,
    SECONDBALL = 1,
    THIRDBALL = 2
} ballNumber;

@interface ABFrameViewController () {
    NSSet *_pinButtons;
    NSInteger _ballNumber;
}
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

    _ballNumber = FIRSTBALL;
    _pinButtons = [NSSet setWithArray:@[_pin01Button, _pin02Button, _pin03Button, _pin04Button, _pin05Button, _pin06Button, _pin07Button, _pin08Button, _pin09Button, _pin10Button]];
    UIPanGestureRecognizer *knockPinsDown = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(knockPinsDown:)];
    [[self view] addGestureRecognizer:knockPinsDown];
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
    NSMutableSet *fallenPins;
    switch (_ballNumber) {
        case FIRSTBALL:
            fallenPins = _firstBallPins;
            break;
        case SECONDBALL:
            fallenPins = _secondBallPins;
            break;
        case THIRDBALL:
            break;
        default:
            break;
    }
    if ([fallenPins containsObject:pinNumber]) {
        [sender setImage:uprightPinImage forState:UIControlStateNormal];
        [fallenPins removeObject:pinNumber];
    } else {
        [sender setImage:fallenPinImage forState:UIControlStateNormal];
        [fallenPins addObject:pinNumber];
    }
    NSLog(@"Button tag: %@", buttonNumber);
    NSLog(@"_firstBallPins: %@", fallenPins);
}

- (void)knockPinsDown:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:[self view]];
    NSMutableSet *fallenPins;
    switch (_ballNumber) {
        case FIRSTBALL:
            fallenPins = _firstBallPins;
            break;
        case SECONDBALL:
            fallenPins = _secondBallPins;
            break;
        case THIRDBALL:
            break;
        default:
            break;
    }
    for (UIButton *pinButton in _pinButtons) {
        NSNumber *pinNumber = @([pinButton tag]-100);
        if (![fallenPins containsObject:pinNumber] && CGRectContainsPoint([pinButton frame], location)) {
            [self pinButtonPressed:pinButton];
        }
    }
}

#pragma mark - ABScoreViewDelegate Methods

- (NSInteger)currentFrameNumber
{
    return 6;
}

- (NSString *)firstBallForFrameNumber:(NSInteger)frameNumber
{
    return [@(arc4random()%10) stringValue];
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
    return [@(arc4random()%10) stringValue];
//    Frame *frame = [[self game] frames][frameNumber];
//    NSString *mark;
//    if ([frame isSpare]) {
//        mark = @"/";
//    } else {
//        mark = [NSString stringWithFormat:@"%i", [frame secondBall]];
//    }
//    return mark;
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
    return [@(arc4random()%300) stringValue];
//    Frame *frame = [[self game] frames][frameNumber];
//#pragma unused (frame) // Will use frame to implement "don't mark score while striking".
//    NSString *mark;
//    mark = [NSString stringWithFormat:@"%i", [[self game] scoreForFrameNumber:frameNumber]];
//    return mark;
}

@end
