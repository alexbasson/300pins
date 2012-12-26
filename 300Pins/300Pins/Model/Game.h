//
//  Game.h
//  300Pins
//
//  Created by Alex on 12/26/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BowlingAlley, Frame;

@interface Game : NSManagedObject

@property (nonatomic, readonly) int16_t score;
@property (nonatomic) NSTimeInterval date;
@property (nonatomic, retain) NSOrderedSet *frames;
@property (nonatomic, retain) BowlingAlley *alley;

#pragma mark - Class Methods

+ (Game *)newGameInManagedObjectContext:(NSManagedObjectContext *)context;

#pragma mark - Instance Methods

- (int16_t)scoreForFrameNumber:(NSInteger)frameNumber;

@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(Frame *)value inFramesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromFramesAtIndex:(NSUInteger)idx;
- (void)insertFrames:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeFramesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInFramesAtIndex:(NSUInteger)idx withObject:(Frame *)value;
- (void)replaceFramesAtIndexes:(NSIndexSet *)indexes withFrames:(NSArray *)values;
- (void)addFramesObject:(Frame *)value;
- (void)removeFramesObject:(Frame *)value;
- (void)addFrames:(NSOrderedSet *)values;
- (void)removeFrames:(NSOrderedSet *)values;
@end
