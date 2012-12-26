//
//  Frame.m
//  300Pins
//
//  Created by Alex on 12/26/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import "Frame.h"
#import "Game.h"


@implementation Frame

@dynamic firstBall;
@dynamic secondBall;
@dynamic thirdBall;
@dynamic strike;
@dynamic spare;
@dynamic game;


#pragma mark - Class Methods

+ (Frame *)newFrameInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Frame" inManagedObjectContext:context];
}


#pragma mark - Transient Property Accessors

- (BOOL)isStrike
{
    if ([self firstBall] == 10) {
        return YES;
    }
    return NO;
}

- (BOOL)isSpare
{
    if ([self firstBall] < 10 && [self firstBall] + [self secondBall] == 10) {
        return YES;
    }
    return NO;
}

@end
