//
//  AppDelegate.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "AppDelegate.h"
#import "Tag.h"

NSString * const CTSAutomaticallyCreateTags = @"AutomaticallyCreateTags";
NSString * const CTSLoadTagsOnLaunch = @"LoadTagsOnLaunch";

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.possibleTags = [[NSMutableArray alloc] initWithArray:@[
        [[Tag alloc] initWithName:@"extract" andColor:NSColor.systemRedColor],
        [[Tag alloc] initWithName:@"electron" andColor:NSColor.systemBlueColor],
        [[Tag alloc] initWithName:@"expansion" andColor:NSColor.systemGreenColor],
        [[Tag alloc] initWithName:@"environment" andColor:NSColor.systemOrangeColor],
        [[Tag alloc] initWithName:@"experience" andColor:NSColor.systemYellowColor],
        [[Tag alloc] initWithName:@"hilarious" andColor:NSColor.systemBrownColor],
        [[Tag alloc] initWithName:@"straw" andColor:NSColor.systemPinkColor],
        [[Tag alloc] initWithName:@"script" andColor:NSColor.systemPurpleColor],
        [[Tag alloc] initWithName:@"damage" andColor:NSColor.systemGrayColor],
        [[Tag alloc] initWithName:@"deposit" andColor:NSColor.systemTealColor],
        [[Tag alloc] initWithName:@"essay" andColor:NSColor.systemIndigoColor],
        [[Tag alloc] initWithName:@"right" andColor:[NSColor colorWithRed:0.10f green:0.52f blue:0.63f alpha:1.0f]],
        [[Tag alloc] initWithName:@"gun" andColor:NSColor.systemRedColor],
        [[Tag alloc] initWithName:@"guess" andColor:NSColor.systemBlueColor],
        [[Tag alloc] initWithName:@"helicopter" andColor:NSColor.systemGreenColor],
        [[Tag alloc] initWithName:@"prestige" andColor:NSColor.systemOrangeColor],
        [[Tag alloc] initWithName:@"outline" andColor:NSColor.systemYellowColor],
        [[Tag alloc] initWithName:@"reduce" andColor:NSColor.systemBrownColor],
        [[Tag alloc] initWithName:@"circumstance" andColor:NSColor.systemPinkColor],
        [[Tag alloc] initWithName:@"reception" andColor:NSColor.systemPurpleColor],
    ]];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:CTSAutomaticallyCreateTags];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:CTSLoadTagsOnLaunch];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
