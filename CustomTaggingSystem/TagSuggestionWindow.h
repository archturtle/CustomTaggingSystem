//
//  TagSuggestionWindow.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import "MainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagSuggestionWindow : NSWindowController <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@property (weak) IBOutlet NSScrollView *scrollView;

@property (strong) IBOutlet NSArrayController *arrayController;

@property MainViewController * target;

@property SEL action;

@property (readonly, nullable) NSDictionary * selectedSuggestion;

- (void)moveSelectionUp;

- (void)moveSelectionDown;

- (void)showSuggestions:(NSArray<NSDictionary *>*)suggestions forView:(NSTextView *)textView;

- (void)cancelSuggestions;

@end

NS_ASSUME_NONNULL_END
