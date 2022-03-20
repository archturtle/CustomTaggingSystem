//
//  TagSuggestionWindow.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 3/19/22.
//

#import "TagSuggestionWindow.h"

@implementation TagSuggestionWindow

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingStoreType defer:(BOOL)flag {
    self = [super initWithContentRect:contentRect styleMask:style backing:backingStoreType defer:flag];
    if (self) {
        [self setOpaque:NO];
        [self setHasShadow:YES];
        [self setBackgroundColor:NSColor.clearColor];
    }
    return self;
}

@end
