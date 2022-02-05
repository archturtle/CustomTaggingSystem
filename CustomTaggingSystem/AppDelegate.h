//
//  AppDelegate.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import "Tag.h"

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
 The list of possible tags that can be shown inside the suggestions
 window.
 */
@property NSMutableArray<Tag *> * possibleTags;

@end

