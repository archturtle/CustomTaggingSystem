//
//  NSString+ComparisonIndex.h
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ComparisonIndex)

- (int)findDifferenceIndexToString:(NSString *)comparison;

@end

NS_ASSUME_NONNULL_END
