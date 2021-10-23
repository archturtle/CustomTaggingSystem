//
//  AppDelegate.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "AppDelegate.h"
#import "Tag.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.possibleTags = [[NSMutableArray alloc] initWithArray:@[
        [[Tag alloc] initWithName:@"extract" Color:NSColor.systemRedColor],
        [[Tag alloc] initWithName:@"electron" Color:NSColor.systemBlueColor],
        [[Tag alloc] initWithName:@"expansion" Color:NSColor.systemGreenColor],
        [[Tag alloc] initWithName:@"environment" Color:NSColor.systemOrangeColor],
        [[Tag alloc] initWithName:@"experience" Color:NSColor.systemYellowColor],
        [[Tag alloc] initWithName:@"hilarious" Color:NSColor.systemBrownColor],
        [[Tag alloc] initWithName:@"straw" Color:NSColor.systemPinkColor],
        [[Tag alloc] initWithName:@"script" Color:NSColor.systemPurpleColor],
        [[Tag alloc] initWithName:@"damage" Color:NSColor.systemGrayColor],
        [[Tag alloc] initWithName:@"deposit" Color:NSColor.systemTealColor],
        [[Tag alloc] initWithName:@"essay" Color:NSColor.systemIndigoColor],
        [[Tag alloc] initWithName:@"right" Color:[NSColor colorWithRed:0.10f green:0.52f blue:0.63f alpha:1.0f]],
        [[Tag alloc] initWithName:@"gun" Color:NSColor.systemRedColor],
        [[Tag alloc] initWithName:@"guess" Color:NSColor.systemBlueColor],
        [[Tag alloc] initWithName:@"helicopter" Color:NSColor.systemGreenColor],
        [[Tag alloc] initWithName:@"prestige" Color:NSColor.systemOrangeColor],
        [[Tag alloc] initWithName:@"outline" Color:NSColor.systemYellowColor],
        [[Tag alloc] initWithName:@"reduce" Color:NSColor.systemBrownColor],
        [[Tag alloc] initWithName:@"circumstance" Color:NSColor.systemPinkColor],
        [[Tag alloc] initWithName:@"reception" Color:NSColor.systemPurpleColor],
    ]];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
