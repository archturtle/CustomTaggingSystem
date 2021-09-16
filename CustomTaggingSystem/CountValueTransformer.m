//
//  CountValueTransformer.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "CountValueTransformer.h"

@implementation CountValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
    NSNumber *count = (NSNumber *) value;
    
    return [NSString stringWithFormat:@"Items: %d", count.intValue];
}

@end
