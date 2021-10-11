//
//  TagTextAttachmentCell.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/10/21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagTextAttachmentCell : NSTextAttachmentCell

/**
 The y-value for the cell's baseline offset.
 */
@property double verticalOffset;

@end

NS_ASSUME_NONNULL_END
