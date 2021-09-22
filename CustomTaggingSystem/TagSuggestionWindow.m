//
//  TagSuggestionWindow.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "TagSuggestionWindow.h"

@interface TagSuggestionWindow ()

/**
 The focus observer which notifies the window that the user
 has clicked out of it.
 */
@property id focusObserver;

/**
 Calculates the proper height for the suggestion window so that
 it shoes all the suggestions. If the amount of suggestions passes
 the number 8, a fixed height is used.
 */
- (void)calculateProperHeight;

@end

@implementation TagSuggestionWindow

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}

@synthesize selectedSuggestion = _selectedSuggestion;

- (NSDictionary *)selectedSuggestion {
    NSInteger currentRow = self.tableView.selectedRow;
    return currentRow == -1 ? nil : [self.arrayController.arrangedObjects objectAtIndex:currentRow];
}

- (void)showSuggestions:(NSArray<NSDictionary *> *)suggestions forView:(NSTextView *)textView {
    if (suggestions.count == 0) return [self cancelSuggestions];
    
    [self.arrayController setContent:suggestions];
    [self.tableView reloadData];
    
    NSWindow *suggestionsWindow = self.window;
    NSWindow *textViewWindow = textView.window;
    NSRect textViewRect = [textView convertRect:textView.bounds toView:nil];
    textViewRect = [textViewWindow convertRectToScreen:textViewRect];
    textViewRect.origin.y -= 5;
    [suggestionsWindow setFrameTopLeftPoint:textViewRect.origin];

    NSRect suggestionsWindowFrame = suggestionsWindow.frame;
    suggestionsWindowFrame.size.width = textView.frame.size.width;
    [suggestionsWindow setFrame:suggestionsWindowFrame display:false];
    [self calculateProperHeight];
        
    [textViewWindow addChildWindow:suggestionsWindow ordered:NSWindowAbove];
        
    self.focusObserver = [NSNotificationCenter.defaultCenter addObserverForName:NSWindowDidResignKeyNotification object:textViewWindow queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self cancelSuggestions];
    }];
}

- (void)calculateProperHeight {
    NSRect contentFrame = self.window.contentView.frame;
    NSRect frame;
    frame.size.height = 0.0f;
    frame.size.width = contentFrame.size.width;
    frame.origin = NSMakePoint(0, 0);
    frame.origin.y = 20.0f + ((self.tableView.numberOfRows < 9) ? self.tableView.rowHeight * self.tableView.numberOfRows : 160.0f);
    
    contentFrame.size.height = NSMaxY(frame);

    NSRect windowFrame = self.window.frame;
    windowFrame.origin.y = NSMaxY(windowFrame) - NSHeight(contentFrame);
    windowFrame.size.height = NSHeight(contentFrame);
    [self.window setFrame:windowFrame display:YES];
}

- (void)cancelSuggestions {
    [self.tableView deselectAll:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self.focusObserver];
    [self.window.parentWindow removeChildWindow:self.window];
    [self.window orderOut:nil];
}

#pragma mark - Table View Controls

- (void)moveSelectionUp {
    int nextRow = MAX((int) self.tableView.selectedRow - 1, 0);
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:nextRow] byExtendingSelection:NO];
    [self.tableView scrollRowToVisible:nextRow];
}

- (void)moveSelectionDown {
    int nextRow = MIN((int) self.tableView.selectedRow + 1, (int) [self.arrayController.arrangedObjects count] - 1);
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:nextRow] byExtendingSelection:NO];
    [self.tableView scrollRowToVisible:nextRow];
}

#pragma mark - Table View Data

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    [NSApp sendAction:self.action to:self.target from:nil];
}

@end
