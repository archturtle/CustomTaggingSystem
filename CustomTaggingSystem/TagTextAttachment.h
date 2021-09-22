//
//  TagTextAttachment.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagTextAttachment : NSTextAttachment

/**
 The name of the tag that the text attachment is representing.
 */
@property NSString * name;

@end

NS_ASSUME_NONNULL_END
