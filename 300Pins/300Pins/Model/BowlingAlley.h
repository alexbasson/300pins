//
//  BowlingAlley.h
//  300Pins
//
//  Created by Alex on 12/26/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface BowlingAlley : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSSet *games;

+ (BowlingAlley *)newBowlingAlleyInManagedObjectContext:(NSManagedObjectContext *)context;

@end

@interface BowlingAlley (CoreDataGeneratedAccessors)

- (void)addGamesObject:(Game *)value;
- (void)removeGamesObject:(Game *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

@end
