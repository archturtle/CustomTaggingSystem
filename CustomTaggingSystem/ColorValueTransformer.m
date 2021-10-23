//
//  ColorValueTransformer.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 10/22/21.
//

#import "ColorValueTransformer.h"

@implementation ColorValueTransformer

+ (Class)transformedValueClass {
    return [NSImage class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
    NSColor *color = (NSColor *) value;
    
    // Create rect and size objects
    NSRect tagColorRect = NSMakeRect(2.0, 2.0, 12.0, 12.0);
    NSSize tagColorSize = NSMakeSize(16.0, 16.0);
    
    // Create image
    NSImage *tagColor = [[NSImage alloc] initWithSize:tagColorSize];
    
    // Start drawing
    [tagColor lockFocus];
    
    // Rounded Corners
    NSBezierPath *bezPath = [NSBezierPath bezierPathWithRoundedRect:tagColorRect xRadius:8.0f yRadius:8.0f];
    [bezPath addClip];
    
    // Fill color
    [color setFill];
    NSRectFill(tagColorRect);
    
    // End drawing
    [tagColor unlockFocus];
    
    return tagColor;
}

@end
