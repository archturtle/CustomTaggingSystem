//
//  TagSuggestionWindow.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "TagSuggestionWindowController.h"
#import "AppDelegate.h"
#import "TagSuggestionWindow.h"
#import "TagSuggestionView.h"

@interface TagSuggestionWindowController ()

/**
 The current content view of the tag suggestion window.
 */
@property (nonatomic) TagSuggestionView * contentView;

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

@implementation TagSuggestionWindowController

- (instancetype)init
{
    NSRect contentRec = {{0,0}, {20, 20}};
    NSWindow *window = [[TagSuggestionWindow alloc] initWithContentRect:contentRec styleMask:NSWindowStyleMaskBorderless backing:NSBackingStoreBuffered defer:YES];
    
    self = [super initWithWindow:window];
    if (self) {
        NSArray *tla = nil;
        [[NSBundle mainBundle] loadNibNamed:@"TagSuggestionView" owner:window topLevelObjects:&tla];
        
        TagSuggestionView *view = [tla filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:[TagSuggestionView class]];
        }]].firstObject;
        view.tableView.backgroundColor = NSColor.clearColor;

        window.contentView = view;
    }
    return self;
}

@synthesize selectedSuggestion = _selectedSuggestion;

- (NSDictionary *)selectedSuggestion {
    NSInteger currentRow = self.contentView.tableView.selectedRow;
    return currentRow == -1 ? nil : [self.contentView.arrayController.arrangedObjects objectAtIndex:currentRow];
}

@synthesize contentView = _contentView;

- (TagSuggestionView *)contentView {
    return (TagSuggestionView *) self.window.contentView;
}

- (void)showSuggestions:(NSArray<Tag *> *)suggestions forView:(NSTextView *)textView {
    if (suggestions.count == 0) return [self cancelSuggestions];
    
    [self.contentView.arrayController setContent:suggestions];
    [self.contentView.tableView reloadData];

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
    frame.origin.y = 20.0f + ((self.contentView.tableView.numberOfRows < 8) ?
                              self.contentView.tableView.rowHeight * self.contentView.tableView.numberOfRows :
                              160.0f);

    contentFrame.size.height = NSMaxY(frame);

    NSRect windowFrame = self.window.frame;
    windowFrame.origin.y = NSMaxY(windowFrame) - NSHeight(contentFrame);
    windowFrame.size.height = NSHeight(contentFrame);
    [self.window setFrame:windowFrame display:YES];
}

- (void)cancelSuggestions {
    [self.contentView.tableView deselectAll:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self.focusObserver];
    [self.window.parentWindow removeChildWindow:self.window];
    [self.window orderOut:nil];
}

#pragma mark - Table View Controls

- (void)moveSelectionUp {
    int nextRow = MAX((int) self.contentView.tableView.selectedRow - 1, 0);
    [self.contentView.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:nextRow] byExtendingSelection:NO];
    [self.contentView.tableView scrollRowToVisible:nextRow];
}

- (void)moveSelectionDown {
    int nextRow = MIN((int) self.contentView.tableView.selectedRow + 1, (int) [(NSArray *) self.contentView.arrayController.arrangedObjects count] - 1);
    [self.contentView.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:nextRow] byExtendingSelection:NO];
    [self.contentView.tableView scrollRowToVisible:nextRow];
}

#pragma mark - Table View Data

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    [NSApp sendAction:self.action to:self.target from:nil];
}

@end
