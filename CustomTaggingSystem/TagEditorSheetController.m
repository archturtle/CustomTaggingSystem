//
//  TagEditorSheetController.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/27/21.
//

#import "TagEditorSheetController.h"
#import "AppDelegate.h"

@interface TagEditorSheetController ()

/**
 The delegate of the entire application.
 */
@property AppDelegate * appDelegate;

@end

@implementation TagEditorSheetController

- (void)windowDidLoad {
    self.appDelegate = (AppDelegate *) [[NSApplication sharedApplication] delegate];
    
    [self.nameTextField setStringValue:self.tag.name];
    [self.colorWell setColor:self.tag.color];
}

- (IBAction)editButtonClicked:(id)sender {
    // Get the index and edit the tag.
    NSUInteger originalTagIndex = [self.appDelegate.possibleTags indexOfObject:self.tag];
    [self.tag editName:[NSString stringWithFormat:@"%@", self.nameTextField.stringValue] andColor:self.colorWell.color];

    // Update the tag.
    [self.appDelegate.possibleTags replaceObjectAtIndex:originalTagIndex withObject:self.tag];
    
    // Close panel and send the ok
    [[NSColorPanel sharedColorPanel] close];
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseOK];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
}

- (void)mouseDown:(NSEvent *)event {
    [self.window makeFirstResponder:nil];
}

@end
