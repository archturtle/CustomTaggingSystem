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
 The iD of the tag that the text attachment is representing.
 */
@property NSManagedObjectID * tagID;

@end

NS_ASSUME_NONNULL_END
