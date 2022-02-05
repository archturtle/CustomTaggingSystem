//
//  AppDelegate.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>

/**
 The NSUserDefaults key used to see if the app is launching for
 the first time.
 */
extern NSString * const CTSFirstLaunch;

/**
 The NSUserDefaults key used to see if tags should be automatically
 created.
 */
extern NSString * const CTSAutomaticallyCreateTags;

/**
 The NSUserDefaults key used to see if tags should be loaded on
 launch.
 */
extern NSString * const CTSLoadTagsOnLaunch;

@interface AppDelegate : NSObject <NSApplicationDelegate>

/**
 The container that lets us use CoreData in our app.
 */
@property (readonly, strong) NSPersistentContainer *persistentContainer;

/**
 The function that is used to write changes to CoreData.
 
 @param sender The view that is sending the action.
 */
- (IBAction)saveAction:(id)sender;

@end

