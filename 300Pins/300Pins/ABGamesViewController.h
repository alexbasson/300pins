//
//  ABGamesViewController.h
//  300Pins
//
//  Created by Alex on 2/8/13.
//  Copyright (c) 2013 Alex Basson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABGamesViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
