//
//  ABScoreView.h
//  300Pins
//
//  Created by Alex on 12/26/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABScoreView.h"

@protocol ABScoreViewDelegate <NSObject>

- (NSString *)firstBallForFrameNumber:(NSInteger)frameNumber;
- (NSString *)secondBallForFrameNumber:(NSInteger)frameNumber;
- (NSString *)thirdBall;
- (NSString *)scoreForFrameNumber:(NSInteger)frameNumber;
- (NSInteger)currentFrameNumber;

@end

@interface ABScoreView : UIView
@property (nonatomic, weak) IBOutlet id<ABScoreViewDelegate> delegate;
@end
