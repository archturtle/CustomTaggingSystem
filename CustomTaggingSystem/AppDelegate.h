//
//  AppDelegate.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>

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

