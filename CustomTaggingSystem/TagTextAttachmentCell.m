//
//  TagTextAttachmentCell.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/10/21.
//

#import "TagTextAttachmentCell.h"

@implementation TagTextAttachmentCell

- (NSPoint)cellBaselineOffset {
    NSPoint original = [super cellBaselineOffset];
    original.y = self.verticalOffset;
    
    return original;
}

@end
