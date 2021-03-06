//
//  TagTextView.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/23/21.
//

#import <Cocoa/Cocoa.h>
#import "TagTextViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagTextView : NSTextView <NSSharingServicePickerDelegate>

/**
 The delegate that the view calls when using delegate methods.
 */
@property (nullable, weak) id<TagTextViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
