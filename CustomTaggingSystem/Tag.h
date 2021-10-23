//
//  Tag.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/22/21.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tag : NSObject

/**
 The ID of the tag.
 */
@property (readonly) NSString * ID;

/**
 The name the tag should display when added.
 */
@property (readonly) NSString * name;

/**
 The color the tag should display when added.
 */
@property (readonly) NSColor * color;

/**
 The number of items the tag is assigned to.
 */
@property (readonly) int items;

- (instancetype) init __attribute__((unavailable("init not available, use initWithName:Color:")));

/**
 A convienince initializer to create a new tag. In this initializer, the ID
 and the number of items are randomly generated.
 
 @param name The name of the tag.
 @param color The color of the tag.
 
 @return A new instance of Tag.
 */
- (instancetype) initWithName:(NSString *)name Color:(NSColor *)color;

@end

NS_ASSUME_NONNULL_END
