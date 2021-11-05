//
//  TagEditorSheetController.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/27/21.
//

#import "TagEditorSheetController.h"
#import "Tag+CoreDataClass.h"
#import "AppDelegate.h"

@interface TagEditorSheetController ()

/**
 The delegate of the entire application.
 */
@property AppDelegate * appDelegate;

@end

@implementation TagEditorSheetController

- (void)windowDidLoad {
    self.appDelegate = NSApplication.sharedApplication.delegate;
    
    [self.nameTextField setStringValue:self.tag.name];
    [self.colorWell setColor:self.tag.color];
}

- (IBAction)editButtonClicked:(id)sender {
    // Edit the tag.
    self.tag.name = [NSString stringWithFormat:@"%@", self.nameTextField.stringValue];
    self.tag.color = self.colorWell.color;
    
    // Update the tag.
    [self.appDelegate saveAction:nil];
    
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
