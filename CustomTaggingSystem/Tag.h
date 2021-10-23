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

@property (readonly) NSString * ID;

@property (readonly) NSString * name;

@property (readonly) NSColor * color;

@property (readonly) int items;

- (instancetype) init __attribute__((unavailable("init not available, use initWithName:Color:")));

- (instancetype) initWithName:(NSString *)name Color:(NSColor *)color;

@end

NS_ASSUME_NONNULL_END
