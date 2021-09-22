//
//  NSString+ComparisonIndex.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ComparisonIndex)

/**
 Finds the index in which the two strings stop sharing similar
 characters.
 
 @param comparison The string to compare against.
 
 @return The index at which similarities stop.
 */
- (int)findDifferenceIndexToString:(NSString *)comparison;

@end

NS_ASSUME_NONNULL_END
