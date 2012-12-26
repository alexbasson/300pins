//
//  Game.m
//  300Pins
//
//  Created by Alex on 12/26/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import "Game.h"
#import "BowlingAlley.h"
#import "Frame.h"


@implementation Game

@dynamic score;
@dynamic date;
@dynamic frames;
@dynamic alley;


#pragma mark - Class Methods

+ (Game *)newGameInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:context];
}

#pragma mark - Transient Property Accessors

- (int16_t)score
{
    return [self scoreForFrameNumber:[[self frames] count]];
}

#pragma mark - Instance Methods

/*
 * returns the game score up through the given frame number,
 * where frameNumber is the number of the frame in the context
 * of the game, i.e. frameNumber is 1-indexed.
 */
- (int16_t)scoreForFrameNumber:(NSInteger)frameNumber
{
    int16_t score = 0;
    for (NSInteger i = 0; i < frameNumber; i++) {
        Frame *frame = [self frames][i];
        if ([frame isStrike]) {
            // Score a strike: add 10 plus the next two balls.
            score += 10;
            if (frameNumber < 10) {
                Frame *nextFrame = [self frames][i+1];
                score += [nextFrame firstBall];
                if ([nextFrame isStrike] && i+1 < 10) {
                    Frame *nextNextFrame = [self frames][i+2];
                    score += [nextNextFrame firstBall];
                } else {
                    score += [nextFrame secondBall];
                }
            } else {
                score += [frame secondBall] + [frame thirdBall];
            }
        } else if ([frame isSpare]) {
            // Score a spare: add 10 + the first ball of the next frame,
            // if there is a next frame. Otherwise add the third ball.
            if (frameNumber < 10) {
                Frame *nextFrame = [self frames][i+1];
                score += 10 + [nextFrame firstBall];
            } else {
                score += 10 + [frame thirdBall];
            }
        } else {
            // Neither a strike nor spare: just add the two balls of the frame.
            score += [frame firstBall] + [frame secondBall];
        }
    }
    return score;
}

@end
