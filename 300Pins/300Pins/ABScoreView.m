//
//  ABScoreView.m
//  300Pins
//
//  Created by Alex on 12/26/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import "ABScoreView.h"

@implementation ABScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] setStroke];
    [[UIColor blackColor] setFill];
    
    UIFont *scoreFont = [UIFont boldSystemFontOfSize:12];
    UIFont *ballFont = [UIFont systemFontOfSize:10];
    
    // draw outer rectangle
    CGContextAddRect(context, rect);
    
    CGFloat frameWidth = rect.size.width/10.f;
    CGRect frameRect = CGRectMake(rect.origin.x, rect.origin.y, frameWidth, rect.size.height);
    CGFloat ballWidth = MIN(frameWidth/3.f, rect.size.height/3.f);
    CGRect scoreRect = CGRectMake(rect.origin.x + 6.f, rect.origin.y + ballWidth + 5.f, frameWidth, rect.size.height - ballWidth);
    CGRect firstBallRect = CGRectMake(rect.origin.x + frameWidth - 2.f*ballWidth, rect.origin.y, ballWidth, ballWidth);
    CGRect firstBallScoreRect = (CGRect){.origin = CGPointMake(firstBallRect.origin.x + 2.f, firstBallRect.origin.y - 1.f), .size = firstBallRect.size};
    CGRect secondBallRect = CGRectMake(rect.origin.x + frameWidth - ballWidth, rect.origin.y, ballWidth, ballWidth);
    CGRect secondBallScoreRect = (CGRect){.origin = CGPointMake(secondBallRect.origin.x + 2.f, secondBallRect.origin.y - 1.f), .size = secondBallRect.size};
    for (NSInteger i = 0; i < 10; i++) {
        CGContextAddRect(context, frameRect);
        CGContextAddRect(context, firstBallRect);
        CGContextAddRect(context, secondBallRect);
        
        [@"5" drawInRect:firstBallScoreRect withFont:ballFont];
        [@"3" drawInRect:secondBallScoreRect withFont:ballFont];
        [@"222" drawInRect:scoreRect withFont:scoreFont];
//        if (_delegate) {
//            if ([_delegate respondsToSelector:@selector(firstBallForFrameNumber:)]) {
//                [[_delegate firstBallForFrameNumber:i] drawInRect:firstBallScoreRect withFont:ballFont];
//            } else {
//                NSLog(@"Error: delegate must implement firstBallForFrameNumber:");
//            }
//            
//            if ([_delegate respondsToSelector:@selector(secondBallForFrameNumber:)]) {
//                [[_delegate secondBallForFrameNumber:i] drawInRect:secondBallScoreRect withFont:ballFont];
//            } else {
//                NSLog(@"Error: delegate must implement secondBallForFrameNumber:");
//            }
//            
//            if ([_delegate respondsToSelector:@selector(scoreForFrameNumber:)]) {
//                [@"222" drawInRect:scoreRect withFont:scoreFont];
//            } else {
//                NSLog(@"Error: delegate must implement scoreForFrameNumber:");
//            }
//        } else {
//            NSLog(@"Error: delegate not set.");
//        }

        frameRect.origin.x += frameWidth;
        scoreRect.origin.x += frameWidth;
        firstBallRect.origin.x += frameWidth;
        firstBallScoreRect.origin.x += frameWidth;
        secondBallRect.origin.x += frameWidth;
        secondBallScoreRect.origin.x += frameWidth;
        if (i == 8) {
            firstBallScoreRect.origin.x -= ballWidth;
            secondBallScoreRect.origin.x -= ballWidth;
        }
    }
    CGRect thirdBallRect = CGRectMake(rect.size.width - 3.f*ballWidth, rect.origin.y, ballWidth, ballWidth);
    CGContextAddRect(context, thirdBallRect);
    
    CGContextSetLineWidth(context, 1.f);
    CGContextStrokePath(context);
}


@end
