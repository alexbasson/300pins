//
//  Frame.h
//  300Pins
//
//  Created by Alex on 12/26/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Frame : NSManagedObject

@property (nonatomic) int16_t firstBall;
@property (nonatomic) int16_t secondBall;
@property (nonatomic) int16_t thirdBall;
@property (nonatomic, getter=isStrike) BOOL strike;
@property (nonatomic, getter=isSpare) BOOL spare;
@property (nonatomic, retain) Game *game;

@end
