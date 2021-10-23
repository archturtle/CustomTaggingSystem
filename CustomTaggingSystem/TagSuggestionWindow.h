//
//  TagSuggestionWindow.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import "MainViewController.h"
#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagSuggestionWindow : NSWindowController <NSTableViewDelegate, NSTableViewDataSource>

/**
 The binding to the tableView that is used to display the
 suggestions.
 */
@property (weak) IBOutlet NSTableView *tableView;

/**
 The binding to the scrollView which contains the tableView.
 */
@property (weak) IBOutlet NSScrollView *scrollView;

/**
 The binding to the array controller which contains all the
 suggestions.
 */
@property (strong) IBOutlet NSArrayController *arrayController;

/**
 The target that the window should notify when the selection of the
 table view changes.
 */
@property MainViewController * target;

/**
 The action that the window should notify the target about.
*/
@property SEL action;

/**
 The currently selected suggestion as per the table view.
 */
@property (readonly, nullable) Tag * selectedSuggestion;

/**
 Moves the selection of the table view up one.
 */
- (void)moveSelectionUp;

/**
 Moves the selection of the table view down one.
 */
- (void)moveSelectionDown;

/**
 Shows the suggestion window with a specific list of suggestions and
 for a specific view. The list of suggestion provided in this method
 are assigned to the array controller.
 
 @param suggestions The list of suggestions the window should display.
 @param textView The text view for which the suggestion window should
 be displayed for.
*/
- (void)showSuggestions:(NSArray<Tag *>*)suggestions forView:(NSTextView *)textView;

/**
 Stops the suggestion window from showing.
 */
- (void)cancelSuggestions;

@end

NS_ASSUME_NONNULL_END
