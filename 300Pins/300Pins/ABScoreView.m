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
    [[UIColor clearColor] setFill];
    
    // draw outer rectangle
    CGContextAddRect(context, rect);
    
    CGFloat frameWidth = rect.size.width/10.f;
    CGRect frameRect = CGRectMake(rect.origin.x, rect.origin.y, frameWidth, rect.size.height);
    CGFloat ballWidth = MIN(frameWidth/3.f, rect.size.height/3.f);
    CGRect firstBallRect = CGRectMake(rect.origin.x + frameWidth - 2.f*ballWidth, rect.origin.y, ballWidth, ballWidth);
    CGRect secondBallRect = CGRectMake(rect.origin.x + frameWidth - ballWidth, rect.origin.y, ballWidth, ballWidth);
    for (NSInteger i = 0; i < 10; i++) {
        CGContextAddRect(context, frameRect);
        CGContextAddRect(context, firstBallRect);
        CGContextAddRect(context, secondBallRect);

        frameRect.origin.x += frameWidth;
        firstBallRect.origin.x += frameWidth;
        secondBallRect.origin.x += frameWidth;
    }
    CGRect thirdBallRect = CGRectMake(rect.size.width - 3.f*ballWidth, rect.origin.y, ballWidth, ballWidth);
    CGContextAddRect(context, thirdBallRect);
    
    CGContextSetLineWidth(context, 1.f);
    CGContextStrokePath(context);
}


@end
