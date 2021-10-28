//
//  Tag.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/22/21.
//

#import "Tag.h"

@interface Tag ()

/**
 The ID of the tag. This property is readwrite.
 */
@property (readwrite) NSString * ID;

/**
 The name the tag should display when added. This property is readwrite.
 */
@property (readwrite) NSString * name;

/**
 The color the tag should display when added. This property is readwrite.
 */
@property (readwrite) NSColor * color;

/**
 The number of items the tag is assigned to. This property is readwrite.
 */
@property (readwrite) int items;

@end

@implementation Tag

- (instancetype)initWithName:(NSString *)name Color:(NSColor *)color {
    self = [super init];
    if (self) {
        self.ID = [[[[NSUUID UUID] UUIDString] substringToIndex:8] lowercaseString];
        self.name = name;
        self.color = color;
        self.items = arc4random_uniform(40000);
    }
    return self;
}

- (void)editedName:(NSString *)newName Color:(NSColor *)newColor {
    self.name = newName;
    self.color = newColor;
}

@end
