//
//  TagEditorSheetController.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/27/21.
//

#import <Cocoa/Cocoa.h>
#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagEditorSheetController : NSWindowController

/**
 The tag that is being edited.
 */
@property Tag * tag;

/**
 The text field used to display and edit the name of the tag.
 */
@property (weak) IBOutlet NSTextField *nameTextField;

/**
 The color well that is used to display and edit the current color
 of the tag.
 */
@property (weak) IBOutlet NSColorWell *colorWell;

@end

NS_ASSUME_NONNULL_END
