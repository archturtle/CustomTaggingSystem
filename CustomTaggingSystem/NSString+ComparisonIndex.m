//
//  NSString+ComparisonIndex.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "NSString+ComparisonIndex.h"

@implementation NSString (ComparisonIndex)

- (int)findDifferenceIndexToString:(NSString *)comparison {
    int retVal = 0;
    
    for (int i = 0; i < MIN(self.length, comparison.length); i++) {
        if ([self characterAtIndex:i] == [comparison characterAtIndex:i]) {
            retVal++;
        } else break;
    }
    
    return retVal;
}

@end
