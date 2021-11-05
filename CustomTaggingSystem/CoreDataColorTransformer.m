//
//  CoreDataColorTransformer.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 11/3/21.
//

#import "CoreDataColorTransformer.h"

@implementation CoreDataColorTransformer

+ (Class)transformedValueClass {
    return [NSColor class];
}

- (id)transformedValue:(id)value {
    NSColor *color = (NSColor *) value;
    
    return [NSKeyedArchiver archivedDataWithRootObject:color requiringSecureCoding:false error:nil];
}

- (id)reverseTransformedValue:(id)value {
    NSData *data = (NSData *) value;
    
    return [NSKeyedUnarchiver unarchivedObjectOfClass:[NSColor class] fromData:data error:nil];
}

@end
