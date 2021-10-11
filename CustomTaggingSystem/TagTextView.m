//
//  TagTextView.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/23/21.
//

#import "TagTextView.h"

@implementation TagTextView

- (NSMenu *)menuForEvent:(NSEvent *)event {
    return [[NSMenu alloc] init];
}

- (NSArray<NSSharingService *> *)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker sharingServicesForItems:(NSArray *)items proposedSharingServices:(NSArray<NSSharingService *> *)proposedServices {
    return @[];
}

@end
