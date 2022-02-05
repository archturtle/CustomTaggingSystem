//
//  AppDelegate.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "AppDelegate.h"
#import "Tag+CoreDataClass.h"

NSString * const CTSFirstLaunch = @"FirstLaunchCompleted";
NSString * const CTSAutomaticallyCreateTags = @"AutomaticallyCreateTags";
NSString * const CTSLoadTagsOnLaunch = @"LoadTagsOnLaunch";

@interface AppDelegate ()

/**
 Bulk creates new tags given an array of dictionaries, where the
 dictionaries contain the data for each new tag.
 
 @param data The data to bulk create tags with.
 */
- (void)createTagsWithData:(NSArray *)data;

@end

@implementation AppDelegate

#pragma mark Delegate Methods
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:CTSFirstLaunch]) {
        [self createTagsWithData:@[
            @{ @"name": @"extract", @"color": NSColor.systemRedColor },
            @{ @"name": @"electron", @"color": NSColor.systemBlueColor },
            @{ @"name": @"expansion", @"color": NSColor.systemGreenColor },
            @{ @"name": @"environment", @"color": NSColor.systemOrangeColor },
            @{ @"name": @"experience", @"color": NSColor.systemYellowColor },
            @{ @"name": @"hilarious", @"color": NSColor.systemBrownColor },
            @{ @"name": @"straw", @"color": NSColor.systemPinkColor },
            @{ @"name": @"script", @"color": NSColor.systemPurpleColor },
            @{ @"name": @"damage", @"color": NSColor.systemGrayColor },
            @{ @"name": @"deposit", @"color": NSColor.systemTealColor },
            @{ @"name": @"essay", @"color": NSColor.systemIndigoColor },
            @{ @"name": @"right", @"color": [NSColor colorWithRed:0.10f green:0.52f blue:0.63f alpha:1.0f] },
            @{ @"name": @"gun", @"color": NSColor.systemRedColor },
            @{ @"name": @"guess", @"color": NSColor.systemBlueColor },
            @{ @"name": @"helicopter", @"color": NSColor.systemGreenColor },
            @{ @"name": @"prestige", @"color": NSColor.systemOrangeColor },
            @{ @"name": @"outline", @"color": NSColor.systemYellowColor },
            @{ @"name": @"reduce", @"color": NSColor.systemBrownColor },
            @{ @"name": @"circumstance", @"color": NSColor.systemPinkColor },
            @{ @"name": @"reception", @"color": NSColor.systemPurpleColor },
        ]];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:CTSFirstLaunch];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:CTSAutomaticallyCreateTags];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:CTSLoadTagsOnLaunch];
    }
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

#pragma mark - Self Defined Methods

- (void)createTagsWithData:(NSArray *)data {
    for (NSDictionary *entry in data) {
        Tag *newTag = [[Tag alloc] initWithContext:self.persistentContainer.viewContext];
        newTag.name = entry[@"name"];
        newTag.color = entry[@"color"];
        newTag.count = arc4random_uniform(10000);
    }
    
    [self saveAction:nil];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CustomTaggingSystem"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving and Undo support

- (IBAction)saveAction:(id)sender {
    // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
    NSManagedObjectContext *context = self.persistentContainer.viewContext;

    if (![context commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    NSError *error = nil;
    if (context.hasChanges && ![context save:&error]) {
        // Customize this code block to include application-specific recovery steps.
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
    return self.persistentContainer.viewContext.undoManager;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    // Save changes in the application's managed object context before the application terminates.
    NSManagedObjectContext *context = self.persistentContainer.viewContext;

    if (![context commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (!context.hasChanges) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![context save:&error]) {

        // Customize this code block to include application-specific recovery steps.
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertSecondButtonReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

@end
