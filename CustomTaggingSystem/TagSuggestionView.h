//
//  TagSuggestionView.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 3/19/22.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagSuggestionView : NSView

@property (weak) IBOutlet NSTableView *tableView;

@property (weak) IBOutlet NSScrollView *scrollView;

@property (strong) IBOutlet NSArrayController *arrayController;

@end

NS_ASSUME_NONNULL_END
