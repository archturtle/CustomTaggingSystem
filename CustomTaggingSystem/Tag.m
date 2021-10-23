//
//  Tag.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/22/21.
//

#import "Tag.h"

@interface Tag ()

@property (readwrite) NSString * ID;

@property (readwrite) NSString * name;

@property (readwrite) NSColor * color;

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

@end
