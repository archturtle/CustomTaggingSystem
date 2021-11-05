//
//  TagTextViewDelegate.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/28/21.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TagTextViewDelegate <NSTextViewDelegate>

/**
 A notification that is sent if the user decides to edit the data of
 an existing tag. This notification is used to determine which tag should
 be redrawn in the textview.
 
 @param ID The ID of the tag that was edited.
 */
- (void)tagInformationEdited:(NSManagedObjectID *)ID;

@end

NS_ASSUME_NONNULL_END
