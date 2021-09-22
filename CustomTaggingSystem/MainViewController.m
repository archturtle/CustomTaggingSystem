//
//  MainViewController.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "MainViewController.h"
#import "TagSuggestionWindow.h"
#import "TagTextAttachment.h"
#import "NSString+ComparisonIndex.h"

@interface MainViewController ()

/**
 The list of possible tags that can be shown inside the suggestions
 window.
 */
@property NSMutableArray<NSDictionary *> * possibleTags;

/**
 The list of tags that are currently inside the textView. Updates on
 insertion and deletion of tags.
 */
@property (readonly) NSArray<NSDictionary *> * currentTags;

/**
 The suggestion window that will be used to display all of our
 tag suggestions.
 */
@property TagSuggestionWindow * suggestionWindow;

/**
 The character that NSTextAttachments show up as when accessing the
 string value of our textView.
 */
@property NSString * attachmentCharacter;

/**
 A boolean value that tells the program whether or not the suggestion
 window should appear under the textView.
 */
@property bool stopSuggestions;

/**
 Updates the textView with the content of the currently selected tag in
 the suggestions window.
 */
- (void)updateTextView;

/**
 Creates and inserts a tag into the textView by automatically finding the currently
 selected tag.
 */
- (void)insertTag;

/**
 Creates and inserts a tag into the textView using manually specified data.
 
 @param item The item from which the tag data should be taken from.
 */
- (void)insertTag:(NSDictionary *)item;

/**
 Cleans the textView string by removing attachment characters so
 that only user-inputted text is left.
 
 @param initial The value of the string propety in a textView.
 
 @return The cleaned string without any attachment characters.
 */
- (NSString *)cleanTextViewString:(NSString *)initial;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.possibleTags = [[NSMutableArray alloc] initWithArray:@[
        @{ @"name": @"extract", @"count": @(456), @"color": NSColor.systemRedColor },
        @{ @"name": @"electron", @"count": @(463), @"color": NSColor.systemBlueColor },
        @{ @"name": @"expansion", @"count": @(496), @"color": NSColor.systemGreenColor },
        @{ @"name": @"environment", @"count": @(460), @"color": NSColor.systemOrangeColor },
        @{ @"name": @"experience", @"count": @(4652), @"color": NSColor.systemYellowColor },
        @{ @"name": @"hilarious", @"count": @(416), @"color": NSColor.systemBrownColor },
        @{ @"name": @"straw", @"count": @(46087), @"color": NSColor.systemPinkColor },
        @{ @"name": @"script", @"count": @(496), @"color": NSColor.systemPurpleColor },
        @{ @"name": @"damage", @"count": @(486), @"color": NSColor.systemGrayColor },
        @{ @"name": @"deposit", @"count": @(646), @"color": NSColor.systemTealColor },
        @{ @"name": @"essay", @"count": @(465), @"color": NSColor.systemIndigoColor },
        @{ @"name": @"right", @"count": @(4465), @"color": [NSColor colorWithRed:0.10f green:0.52f blue:0.63f alpha:1.0f] },
        @{ @"name": @"gun", @"count": @(463), @"color": NSColor.systemRedColor },
        @{ @"name": @"guess", @"count": @(416), @"color": NSColor.systemBlueColor },
        @{ @"name": @"helicoper", @"count": @(436), @"color": NSColor.systemGreenColor },
        @{ @"name": @"prestige", @"count": @(456), @"color": NSColor.systemOrangeColor },
        @{ @"name": @"outline", @"count": @(46342), @"color": NSColor.systemYellowColor },
        @{ @"name": @"reduce", @"count": @(2346), @"color": NSColor.systemBrownColor },
        @{ @"name": @"circumstance", @"count": @(4342), @"color": NSColor.systemPinkColor },
        @{ @"name": @"reception", @"count": @(443), @"color": NSColor.systemPurpleColor },
    ]];
            
    [self.textView setDelegate:self];
    [self.textView setTextContainerInset:NSMakeSize(0, 5)];
    
    unichar character = 0xFFFC;
    self.attachmentCharacter = [NSString stringWithCharacters:&character length:1];
}

@synthesize currentTags = _currentTags;

- (NSArray<NSDictionary *> *)currentTags {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    [self.textView.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.textView.textStorage.length) options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value == nil) return;
        
        TagTextAttachment *tag = (TagTextAttachment *) value;
        [list addObject:tag.info];
    }];
    
    return list;
}

- (IBAction)listCurrentTags:(id)sender {
    NSLog(@"currentTags: %@", self.currentTags);
}

- (NSArray<NSDictionary *>*)getPossibleSuggestions:(NSString *)text {
    return [self.possibleTags filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSDictionary *tag = (NSDictionary *) evaluatedObject;
        NSString *tagName = (NSString *) [tag objectForKey:@"name"];
        
        return [tagName hasPrefix:text] && ![self.currentTags containsObject:tag];
    }]];
}

- (void)textDidBeginEditing:(NSNotification *)notification {
    if (!self.suggestionWindow) {
        self.suggestionWindow = [[TagSuggestionWindow alloc] initWithWindowNibName:@"TagSuggestionWindow"];
        self.suggestionWindow.target = self;
        self.suggestionWindow.action = @selector(updateTextView);
    }
                    
    [self.suggestionWindow showSuggestions:[self getPossibleSuggestions:[self cleanTextViewString:self.textView.textStorage.string]] forView:self.textView];
}

- (void)textDidChange:(NSNotification *)notification {
    if (self.stopSuggestions) {
        self.stopSuggestions = NO;
        return [self.suggestionWindow cancelSuggestions];
    }
                
    
    [self.suggestionWindow showSuggestions:[self getPossibleSuggestions:[self cleanTextViewString:self.textView.textStorage.string]] forView:self.textView];
}

- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
    if (commandSelector == @selector(moveUp:) && [self.suggestionWindow.window isVisible]) {
        [self.suggestionWindow moveSelectionUp];
        return YES;
    }
    
    if (commandSelector == @selector(moveDown:) && [self.suggestionWindow.window isVisible]) {
        [self.suggestionWindow moveSelectionDown];
        return YES;
    }
    
    if (commandSelector == @selector(deleteForward:) || commandSelector == @selector(deleteBackward:)) {
        self.stopSuggestions = YES;

        return NO;
    }
    
    if (commandSelector == @selector(insertNewline:)) {
        [self insertTag];
        [self.textView moveRight:nil];
        [self.suggestionWindow cancelSuggestions];
            
        return YES;
    }
    
    if (commandSelector == @selector(complete:)) {
        if (self.suggestionWindow.window.isVisible) {
            [self.suggestionWindow cancelSuggestions];
        } else {
            [self.suggestionWindow showSuggestions:[self getPossibleSuggestions:[self cleanTextViewString:self.textView.textStorage.string]] forView:self.textView];
        }
        
        return YES;
    }
    
    return NO;
}

- (void)insertTag {
    NSDictionary *item;
        
    if (!self.suggestionWindow.selectedSuggestion) {
        NSString *textViewString = [self cleanTextViewString:self.textView.textStorage.string];
        if ([textViewString isEqualToString:@""]) return;
        
        NSArray<NSDictionary *>* results = [self.possibleTags filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                return [(NSString *) [(NSDictionary *) evaluatedObject objectForKey:@"name"] isEqualToString:textViewString];
        }]];
        
        if (results.count == 0) {
            NSDictionary *tagItem = @{
                @"name": [NSString stringWithFormat:@"%@", textViewString],
                @"count": @(1),
                @"color": NSColor.systemGrayColor
            };
                
            item = tagItem;
            [self.possibleTags addObject:tagItem];
        } else {
            item = results.firstObject;
        }
    } else {
        item = self.suggestionWindow.selectedSuggestion;
    }
    
    [self insertTag:item];
}

- (void)insertTag:(NSDictionary *)item {
    [self.textView.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.textView.textStorage.length) options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value != nil) return;
        
        [self.textView setSelectedRange:range];
        [self.textView delete:nil];
    }];
    
    if ([self.currentTags containsObject:item]) return;
    
    NSString *itemName = [item valueForKey:@"name"];
    NSColor *itemColor = [item valueForKey:@"color"];
    
    TagTextAttachment *attachment = [[TagTextAttachment alloc] init];
    NSSize textSize = [itemName sizeWithAttributes:@{
        NSFontAttributeName: [NSFont systemFontOfSize:12]
    }];
        
    NSSize tagSize = textSize;
    tagSize.height += 4.0f;
    tagSize.width += 8.0f;
    
    // Offset the actual tag so that there can be spacing around it
    NSRect tagRect = NSMakeRect(1, 1, tagSize.width - 2, tagSize.height - 2);

    NSImage *tagImage = [[NSImage alloc] initWithSize:tagSize];
    [tagImage lockFocus];
    
    // Create Rounded Corners
    NSBezierPath *bezPath = [NSBezierPath bezierPathWithRoundedRect:tagRect xRadius:2.5f yRadius:2.5f];
    [bezPath addClip];
        
    // Set Fill Color
    [itemColor setFill];
    NSRectFill(tagRect);
        
    // Center the text inside the offset tag
    [itemName drawInRect:NSMakeRect(4.0f, 0.0f, tagSize.width - 2, tagSize.height - 2) withAttributes:@{
        NSFontAttributeName: [NSFont systemFontOfSize:12],
        NSForegroundColorAttributeName: NSColor.textColor
    }];
        
    [tagImage unlockFocus];
        
    // Set bounds of attachment
    [attachment setBounds:NSMakeRect(0, self.textView.font.descender - 2, tagImage.size.width, tagImage.size.height)];
    [attachment setImage:tagImage];
    
    // Set tag name
    [attachment setInfo:item];
    
    NSAttributedString *tag = [NSAttributedString attributedStringWithAttachment:attachment];
    
    [self.textView.textStorage insertAttributedString:tag atIndex:self.textView.selectedRange.location];
}

- (NSString *)cleanTextViewString:(NSString *)initial {
    return [initial stringByReplacingOccurrencesOfString:self.attachmentCharacter withString:@""];
}

- (void)updateTextView {
    if (!self.suggestionWindow.selectedSuggestion) return;
    
    // Electron
    NSString *suggestionName = [self.suggestionWindow.selectedSuggestion valueForKey:@"name"];
    
    // <TagTextAttachment>E|xtract --> E|xtract
    NSString *cleanedText = [self cleanTextViewString:self.textView.textStorage.string];

    // E|xtract
    // E|lectron
    // First Difference at index = 1
    int sliceLocation = [cleanedText findDifferenceIndexToString:suggestionName];
    int __block leadingOffset = 0;
    
    [self.textView.textStorage.string enumerateSubstringsInRange:NSMakeRange(0, self.textView.textStorage.string.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([substring isEqualToString:self.attachmentCharacter]) leadingOffset++;
        else *stop = YES;
    }];
                
    // <TagTextAttachment>E|xtract --> <TagTextAttachment>E|
    // OR
    // <TagTextAttachment>Extract| --> <TagTextAttachment>E|
    [self.textView.textStorage replaceCharactersInRange:NSMakeRange(sliceLocation + leadingOffset, cleanedText.length - sliceLocation) withString:@""];
    
    // E|lectron --> lectron
    NSAttributedString *slicedSuggestion = [[NSAttributedString alloc] initWithString:[suggestionName substringFromIndex:sliceLocation] attributes:self.textView.typingAttributes];

    // Find selection range of lectron
    NSRange suggestionRange = NSMakeRange(sliceLocation + leadingOffset, suggestionName.length - sliceLocation);

    // <TagTextAttachment>E|lectron
    [self.textView.textStorage insertAttributedString:slicedSuggestion atIndex:sliceLocation + leadingOffset];

    // Select selection
    [self.textView setSelectedRange:suggestionRange];
}

- (void)mouseDown:(NSEvent *)event {
    [self insertTag];
    [self.suggestionWindow cancelSuggestions];
    [self.view.window makeFirstResponder:nil];
}

@end
