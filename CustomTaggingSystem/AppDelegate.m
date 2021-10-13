//
//  AppDelegate.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.possibleTags = [[NSMutableArray alloc] initWithArray:@[
        @{ @"id": @"5YpnOaGqkx", @"name": @"extract", @"count": @(456), @"color": NSColor.systemRedColor },
        @{ @"id": @"86amgD0YVN", @"name": @"electron", @"count": @(463), @"color": NSColor.systemBlueColor },
        @{ @"id": @"OUf4ATXct2", @"name": @"expansion", @"count": @(496), @"color": NSColor.systemGreenColor },
        @{ @"id": @"tYi0DqKmlV", @"name": @"environment", @"count": @(460), @"color": NSColor.systemOrangeColor },
        @{ @"id": @"O6EotVmjj4", @"name": @"experience", @"count": @(4652), @"color": NSColor.systemYellowColor },
        @{ @"id": @"MA5IPSNTsa", @"name": @"hilarious", @"count": @(416), @"color": NSColor.systemBrownColor },
        @{ @"id": @"iWzSax96S3", @"name": @"straw", @"count": @(46087), @"color": NSColor.systemPinkColor },
        @{ @"id": @"yW8YCoLUnV", @"name": @"script", @"count": @(496), @"color": NSColor.systemPurpleColor },
        @{ @"id": @"Kcf4axXKsx", @"name": @"damage", @"count": @(486), @"color": NSColor.systemGrayColor },
        @{ @"id": @"PvWCywdHJF", @"name": @"deposit", @"count": @(646), @"color": NSColor.systemTealColor },
        @{ @"id": @"0m5j8OJNn1", @"name": @"essay", @"count": @(465), @"color": NSColor.systemIndigoColor },
        @{ @"id": @"YlvtGNIfOc", @"name": @"right", @"count": @(4465), @"color": [NSColor colorWithRed:0.10f green:0.52f blue:0.63f alpha:1.0f] },
        @{ @"id": @"HX6w4i7YKh", @"name": @"gun", @"count": @(463), @"color": NSColor.systemRedColor },
        @{ @"id": @"mW4RmwSYP7", @"name": @"guess", @"count": @(416), @"color": NSColor.systemBlueColor },
        @{ @"id": @"dmL6TLsNVJ", @"name": @"helicopter", @"count": @(436), @"color": NSColor.systemGreenColor },
        @{ @"id": @"x61oRav75k", @"name": @"prestige", @"count": @(456), @"color": NSColor.systemOrangeColor },
        @{ @"id": @"P3AbmhPqTy", @"name": @"outline", @"count": @(46342), @"color": NSColor.systemYellowColor },
        @{ @"id": @"buYP2C2TJy", @"name": @"reduce", @"count": @(2346), @"color": NSColor.systemBrownColor },
        @{ @"id": @"E9ne4evvgm", @"name": @"circumstance", @"count": @(4342), @"color": NSColor.systemPinkColor },
        @{ @"id": @"14JUTSVvgK", @"name": @"reception", @"count": @(443), @"color": NSColor.systemPurpleColor },
    ]];
}

@end
