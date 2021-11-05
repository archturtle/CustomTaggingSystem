//
//  TagTextView.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/23/21.
//

#import "AppDelegate.h"
#import "TagTextView.h"
#import "TagTextAttachment.h"
#import "TagEditorSheetController.h"
#import "Tag+CoreDataClass.h"

@interface TagTextView ()

/**
 The shared delegate for the entire application.
 */
@property AppDelegate * appDelegate;

/**
 The object context used to managed Tags.
 */
@property NSManagedObjectContext * context;

/**
 The editor window that is used to edit the data of a selected
 tag.
 */
@property TagEditorSheetController * editorSheet;

@end

@implementation TagTextView

@dynamic delegate;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    self.appDelegate = NSApplication.sharedApplication.delegate;
    self.context = self.appDelegate.persistentContainer.viewContext;
    
    self.editorSheet = [[TagEditorSheetController alloc] initWithWindowNibName:@"TagEditorSheet"];
}

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
        
        // Get the tag.
        Tag *tag = [self.context objectWithID:attachment.tagID];
        // Set data of editorSheet.
        [self.editorSheet setTag:tag];
        
        // Show sheet.
        [self.window beginSheet:self.editorSheet.window completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSModalResponseOK) [self.delegate tagInformationEdited:tag.objectID];
        }];
    }
}

@end
