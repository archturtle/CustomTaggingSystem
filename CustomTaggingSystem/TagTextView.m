//
//  TagTextView.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/23/21.
//

#import "AppDelegate.h"
#import "TagTextView.h"
#import "TagTextAttachment.h"
#import "Tag.h"

@implementation TagTextView

- (NSArray<NSSharingService *> *)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker sharingServicesForItems:(NSArray *)items proposedSharingServices:(NSArray<NSSharingService *> *)proposedServices {
    return @[];
}

/**
 Adapted from https://developer.apple.com/library/archive/samplecode/LayoutManagerDemo/Introduction/Intro.html.
 */
- (void)rightMouseDown:(NSEvent *)event {
    NSUInteger glyphIndex;
    NSRect glyphRect;
    
    // Coordinates of the event.
    NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
    point.x -= self.textContainerOrigin.x;
    point.y -= self.textContainerOrigin.y;
    
    // Glyph Index of the attachment in the NSTextView
    glyphIndex = [self.layoutManager glyphIndexForPoint:point inTextContainer:self.textContainer];
    
    // Bounding rect of the attachment in the NSTextView
    glyphRect = [self.layoutManager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1) inTextContainer:self.textContainer];
    
    // Check if the coordinates of the event are actually in the bounding rect of the attachment.
    if (NSPointInRect(point, glyphRect)) {
        NSUInteger charIndex = [self.layoutManager characterIndexForGlyphAtIndex:glyphIndex];
        TagTextAttachment *attachment = [self.textStorage attribute:NSAttachmentAttributeName atIndex:charIndex effectiveRange:nil];
        
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"id == %@", attachment.tagID];
        NSArray<Tag *> * tags = [((AppDelegate *) NSApplication.sharedApplication.delegate).possibleTags filteredArrayUsingPredicate:filter];
        NSLog(@"%@", attachment.tagID);
        NSLog(@"%@", tags.firstObject);
    }
}

@end
