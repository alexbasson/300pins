//
//  BowlingAlley.m
//  300Pins
//
//  Created by Alex on 12/26/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import "BowlingAlley.h"
#import "Game.h"


@implementation BowlingAlley

@dynamic name;
@dynamic latitude;
@dynamic longitude;
@dynamic games;

#pragma mark - Class Methods

+ (BowlingAlley *)newBowlingAlleyInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"BowlingAlley" inManagedObjectContext:context];
}

@end
