//
//  TagSuggestionView.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 3/19/22.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagSuggestionView : NSView

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

@end

NS_ASSUME_NONNULL_END
