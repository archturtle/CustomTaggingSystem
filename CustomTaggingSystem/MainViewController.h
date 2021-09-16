//
//  MainViewController.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : NSViewController <NSTextViewDelegate>

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

NS_ASSUME_NONNULL_END
