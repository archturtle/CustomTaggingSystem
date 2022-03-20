//
//  RoundedTableView.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 3/19/22.
//

#import "RoundedTableView.h"

@implementation RoundedTableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:5.f yRadius:5.f];
    
    [[NSColor controlBackgroundColor] setFill];
    [path fill];
}

@end
