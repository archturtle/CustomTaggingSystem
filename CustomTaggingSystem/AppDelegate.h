//
//  AppDelegate.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import "Tag.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

/**
 The list of possible tags that can be shown inside the suggestions
 window.
 */
@property NSMutableArray<Tag *> * possibleTags;

@end

