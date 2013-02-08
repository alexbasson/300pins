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
    NSInteger _ballNumber;
    CGPoint _originalBallCenter;
}
@property (nonatomic, strong) NSMutableSet *firstBallPins;
@property (nonatomic, strong) NSMutableSet *secondBallPins;
@property (nonatomic, strong, readonly) NSSet *pinButtons;
@property (nonatomic, strong, readonly) Game *game;
@property (nonatomic, strong, readonly) UITapGestureRecognizer *resetGesture;
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *knockPinsDown;
@end

@implementation ABFrameViewController

@synthesize game = _game;
@synthesize pinButtons = _pinButtons;
@synthesize resetGesture = _resetGesture;
@synthesize knockPinsDown = _knockPinsDown;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithFrameNumber:0];
}

- (id)initWithFrameNumber:(NSInteger)frameNumber
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _frameNumber = frameNumber;
//        _frame = [Frame newFrameInManagedObjectContext:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _ballNumber = FIRSTBALL;
    _originalBallCenter = [[self bowlingBallButton] center];
    [_ballNumberLabel setText:@"1st Ball"];
    [[self view] addGestureRecognizer:[self knockPinsDown]];
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

#pragma mark - Property Accessors

- (NSSet *)pinButtons
{
    if (!_pinButtons) {
        _pinButtons = [NSSet setWithArray:@[_pin01Button, _pin02Button, _pin03Button, _pin04Button, _pin05Button, _pin06Button, _pin07Button, _pin08Button, _pin09Button, _pin10Button]];
    }
    return _pinButtons;
}

- (NSMutableSet *)firstBallPins
{
    if (!_firstBallPins) {
        _firstBallPins = [NSMutableSet setWithCapacity:10];
    }
    return _firstBallPins;
}

- (NSMutableSet *)secondBallPins
{
    if (!_secondBallPins) {
        _secondBallPins = [NSMutableSet setWithCapacity:10];
    }
    return _secondBallPins;
}

- (UITapGestureRecognizer *)resetGesture
{
    if (!_resetGesture) {
        _resetGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reset)];
        [_resetGesture setNumberOfTapsRequired:1];
        [_resetGesture setNumberOfTouchesRequired:1];
    }
    return _resetGesture;
}

- (UIPanGestureRecognizer *)knockPinsDown
{
    if (!_knockPinsDown) {
        _knockPinsDown = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(knockPinsDown:)];
    }
    return _knockPinsDown;
}

#pragma mark - Actions

- (IBAction)pinButtonPressed:(UIButton *)sender
{
    NSNumber *pinNumber = @([sender tag]-100);
    NSString *buttonNumber = [[@([sender tag]) stringValue] substringFromIndex:1];
    UIImage *uprightPinImage = [UIImage imageNamed:[buttonNumber stringByAppendingString:@"pinUpright"]];
    UIImage *fallenPinImage = [UIImage imageNamed:[buttonNumber stringByAppendingString:@"pinFallen"]];
    NSMutableSet *fallenPins;
    switch (_ballNumber) {
        case FIRSTBALL:
            fallenPins = [self firstBallPins];
            break;
        case SECONDBALL:
            fallenPins = [self secondBallPins];
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
    
    if ([fallenPins count] > 0) {
        [self showRecordBallButton];
    } else {
        [self reset];
    }
    NSLog(@"Button tag: %@", buttonNumber);
    NSLog(@"_firstBallPins: %@", fallenPins);
}

- (IBAction)recordBallButtonPressed:(UIButton *)sender
{
    NSLog(@"\"Mark it, Dude.\"");
    if (_frameNumber < 10) {
        if (_ballNumber == 1) {
            [[self ballNumberLabel] setText:@"2nd Ball"];
            // hide the fallen pins
            for (UIButton *pinButton in [self pinButtons]) {
                NSNumber *pinNumber = @([pinButton tag]-100);
                if ([[self firstBallPins] containsObject:pinNumber]) {
                    [pinButton setHidden:YES];
                }
            }
            [self resetBall];
        } else {
            ABFrameViewController *nextFrameViewController = [[ABFrameViewController alloc] initWithFrameNumber:_frameNumber+1];
            [[self navigationController] pushViewController:nextFrameViewController animated:YES];
        }
    } else {
        // deal with this
    }
    _ballNumber += 1;
}


- (void)knockPinsDown:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:[self view]];
    if (!CGRectContainsPoint([_bowlingBallButton frame], location)) {
        return;
    }
    
    [_bowlingBallButton setCenter:location];
    NSMutableSet *fallenPins;
    switch (_ballNumber) {
        case FIRSTBALL:
            fallenPins = [self firstBallPins];
            break;
        case SECONDBALL:
            fallenPins = [self secondBallPins];
            break;
        case THIRDBALL:
            break;
        default:
            break;
    }
    for (UIButton *pinButton in [self pinButtons]) {
        NSNumber *pinNumber = @([pinButton tag]-100);
        if (![fallenPins containsObject:pinNumber] && ![pinButton isHidden] && CGRectContainsPoint([pinButton frame], location)) {
            [self pinButtonPressed:pinButton];
        }
    }
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        [[self view] removeGestureRecognizer:[self knockPinsDown]];
        [self showRecordBallButton];
    }
}

- (void)showRecordBallButton
{
    [[self bowlingBallButton] setImage:[UIImage imageNamed:@"bowlingBallReset"]];
    [[self bowlingBallButton] addGestureRecognizer:[self resetGesture]];

    NSString *recordButtonTitle;
    if (_ballNumber == FIRSTBALL) {
        if ([[self firstBallPins] count] == 10) {
            recordButtonTitle = @"\"Mark it a strike, Dude.\"";
        } else {
            recordButtonTitle = [NSString stringWithFormat:@"\"Mark it '%i', Dude.\"", [[self firstBallPins] count]];
        }
    } else if (_ballNumber == SECONDBALL) {
        if ([[self firstBallPins] count] + [[self secondBallPins] count] == 10) {
            recordButtonTitle = @"\"Mark it a spare, Dude.\"";
        } else {
            recordButtonTitle = [NSString stringWithFormat:@"\"Mark it '%i', Dude.\"", [[self secondBallPins] count]];
        }
    }
    [[self recordBallButton] setTitle:recordButtonTitle forState:UIControlStateNormal];

    [[self recordBallButton] setHidden:NO];
}

- (void)reset
{
    NSMutableSet *fallenPins;
    switch (_ballNumber) {
        case FIRSTBALL:
            fallenPins = [self firstBallPins];
            break;
        case SECONDBALL:
            fallenPins = [self secondBallPins];
            break;
        default:
            break;
    }
    [fallenPins removeAllObjects];
    for (UIButton *pinButton in [self pinButtons]) {
        NSString *buttonNumber = [[@([pinButton tag]) stringValue] substringFromIndex:1];
        [pinButton setImage:[UIImage imageNamed:[buttonNumber stringByAppendingString:@"pinUpright"]] forState:UIControlStateNormal];
    }
    [self resetBall];
}

- (void)resetBall
{
    [[self bowlingBallButton] setImage:[UIImage imageNamed:@"bowlingBall"]];
    [[self bowlingBallButton] setCenter:_originalBallCenter];
    [[self bowlingBallButton] removeGestureRecognizer:[self resetGesture]];
    [[self view] addGestureRecognizer:[self knockPinsDown]];
    [[self recordBallButton] setHidden:YES];    
}

#pragma mark - ABScoreViewDelegate Methods

- (NSInteger)currentFrameNumber
{
    return _frameNumber;
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
