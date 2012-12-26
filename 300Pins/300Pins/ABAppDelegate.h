//
//  ABAppDelegate.h
//  300Pins
//
//  Created by Alex on 12/25/12.
//  Copyright (c) 2012 Alex Basson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) UINavigationController *navigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
