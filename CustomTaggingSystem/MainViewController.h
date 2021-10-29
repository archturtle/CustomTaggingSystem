//
//  MainViewController.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>
#import "TagTextView.h"
#import "TagTextViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : NSViewController <TagTextViewDelegate>

/**
 The binding to the text view that is used for input and tagging.
 */
@property (unsafe_unretained) IBOutlet TagTextView *textView;

@end

NS_ASSUME_NONNULL_END
