//
//  MainViewController.m
//  CustomTaggingSystem
//
//  Created by Siddhartha Juluru on 9/15/21.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "TagSuggestionWindowController.h"
#import "TagTextAttachment.h"
#import "NSString+ComparisonIndex.h"

@interface MainViewController ()

/**
 The shared delegate for the entire application.
 */
@property AppDelegate * appDelegate;

/**
 The list of tags that are currently inside the textView. Updates on
 insertion and deletion of tags.
 */
@property (readonly) NSArray<NSString *> * currentTags;

/**
 The suggestion window that will be used to display all of our
 tag suggestions.
 */
@property TagSuggestionWindowController * suggestionWindow;

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
 The path at which the save file for tags is located.
 */
@property NSString * saveFilePath;

/**
 The boolean used to determine if a tag should be automatically created
 if it doesn't exist.
 */
@property bool shouldAutomaticallyCreate;

/**
 Toggles the shouldCreate property based on the value of the suppression
 button in the NSAlert.
 */
- (void)toggleShouldCreate;

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
- (void)insertTag:(Tag *)item;

/**
 Redraws a tag in the textview at a specific index.
 
 @param ID The ID of the tag that should be redrawn.
 */
- (void)redrawTag:(NSString *)ID;

/**
 Cleans the textView string by removing attachment characters so
 that only user-inputted text is left.
 
 @param initial The value of the string property in a textView.
 
 @return The cleaned string without any attachment characters.
 */
- (NSString *)cleanTextViewString:(NSString *)initial;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = NSApplication.sharedApplication.delegate;
    
    [self.textView setDelegate:self];
    [self.textView setTextContainerInset:NSMakeSize(0, 5)];
    [self.textView unregisterDraggedTypes];
    
    unichar character = 0xFFFC;
    self.attachmentCharacter = [NSString stringWithCharacters:&character length:1];
    
    self.saveFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Tags.plist"];
    
    // Uncomment Load saved tags on app startup.
//    [self loadTags:nil];
}

@synthesize currentTags = _currentTags;

- (NSArray<NSString *> *)currentTags {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    [self.textView.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.textView.textStorage.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value == nil) return;
        
        NSString *tagID = ((TagTextAttachment *) value).tagID;
        [list addObject:tagID];
    }];
    
    return list;
}


- (NSArray<Tag *>*)getPossibleSuggestions:(NSString *)text {
    return [self.appDelegate.possibleTags filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Tag *tag = (Tag *) evaluatedObject;
        
        return [tag.name hasPrefix:text] && ![self.currentTags containsObject:tag.ID];
    }]];
}

- (IBAction)listCurrentTags:(id)sender {
    NSLog(@"currentTags: %@", self.currentTags);
}

- (IBAction)saveTags:(id)sender {
    NSDictionary *saveFileData = @{
        @"Tags": [self currentTags]
    };

    [saveFileData writeToFile:self.saveFilePath atomically:YES];
}

- (IBAction)loadTags:(id)sender {
    NSDictionary *saveFileData = [[NSDictionary alloc] initWithContentsOfFile:self.saveFilePath];
    
    for (NSString *ID in [saveFileData objectForKey:@"Tags"]) {
        if ([self.currentTags containsObject:ID]) return;
    
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"ID == %@", ID];
        NSArray<Tag *> * tags = [self.appDelegate.possibleTags filteredArrayUsingPredicate:filter];
        if (tags.count == 0) return;
        
        [self insertTag:tags.firstObject];
    }
}

- (void)textDidBeginEditing:(NSNotification *)notification {
    if (!self.suggestionWindow) {
        self.suggestionWindow = [[TagSuggestionWindowController alloc] initWithWindowNibName:@"TagSuggestionWindow"];
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

- (void)tagInformationEdited:(NSString *)ID {
    NSLog(@"%@", ID);
    [self redrawTag:ID];
}

- (void)insertTag {
    Tag *item;
        
    if (!self.suggestionWindow.selectedSuggestion) {
        NSString *textViewString = [self cleanTextViewString:self.textView.textStorage.string];
        if ([textViewString isEqualToString:@""]) return;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", textViewString];
        NSArray<Tag *>* results = [self.appDelegate.possibleTags filteredArrayUsingPredicate:predicate];
        
        if (results.count == 0) {
            if (!self.shouldAutomaticallyCreate) {
                NSAlert *shouldCreate = [[NSAlert alloc] init];
                
                [shouldCreate setMessageText:[NSString stringWithFormat:@"The tag \"%@\" does not exist. Do you want to create it?", textViewString]];
                [shouldCreate addButtonWithTitle:@"Create"];
                [shouldCreate addButtonWithTitle:@"Cancel"];
                [shouldCreate setShowsSuppressionButton:YES];
                [shouldCreate.suppressionButton setTitle:@"Automatically create new tags"];
                [shouldCreate.suppressionButton setAction:@selector(toggleShouldCreate)];
                
                if ([shouldCreate runModal] != 1000) return;
            }
            
            Tag *newTag = [[Tag alloc] initWithName:[NSString stringWithFormat:@"%@", textViewString] andColor:NSColor.systemGrayColor];
            
            item = newTag;
            [self.appDelegate.possibleTags addObject:newTag];
        } else {
            item = results.firstObject;
        }
    } else {
        item = self.suggestionWindow.selectedSuggestion;
    }
    
    [self insertTag:item];
}

- (void)insertTag:(Tag *)item {
    [self.textView.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.textView.textStorage.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value != nil) return;
        
        [self.textView setSelectedRange:range];
        [self.textView delete:nil];
    }];
    
    if ([self.currentTags containsObject:item.name]) return;
    
    TagTextAttachment *attachment = [[TagTextAttachment alloc] init];
    
    NSSize textSize = [item.name sizeWithAttributes:@{
        NSFontAttributeName: [NSFont systemFontOfSize:12]
    }];
        
    NSSize tagSize = textSize;
    tagSize.height += 4.0f;
    tagSize.width += 8.0f;
    
    // Offset the actual tag so that there can be spacing around it
    NSRect tagRect = NSMakeRect(1, 1, tagSize.width - 2, tagSize.height - 2);
    
    // Create the tag Image
    NSImage *tagImage = [[NSImage alloc] initWithSize:tagSize];
    [tagImage lockFocus];
    
    // Create Rounded Corners
    NSBezierPath *bezPath = [NSBezierPath bezierPathWithRoundedRect:tagRect xRadius:2.5f yRadius:2.5f];
    [bezPath addClip];
        
    // Set Fill Color
    [item.color setFill];
    NSRectFill(tagRect);
        
    // Center the text inside the offset tag
    [item.name drawInRect:NSMakeRect(4.0f, 0.0f, tagSize.width - 2, tagSize.height - 2) withAttributes:@{
        NSFontAttributeName: [NSFont systemFontOfSize:12],
        NSForegroundColorAttributeName: NSColor.textColor
    }];
        
    [tagImage unlockFocus];
    
    // Set the attachment bound
    [attachment setBounds:NSMakeRect(0, self.textView.font.descender - 2, tagImage.size.width, tagImage.size.height)];

    // Set the attachment image
    [attachment setImage:tagImage];
    
    // Set tag name
    [attachment setTagID:item.ID];
    
    NSAttributedString *tag = [NSAttributedString attributedStringWithAttachment:attachment];
    
    [self.textView.textStorage insertAttributedString:tag atIndex:self.textView.selectedRange.location];
}

- (void)redrawTag:(NSString *)ID {
    NSUInteger __block tagIndex = 0;
    [self.textView.textStorage enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.textView.textStorage.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value == nil) return;
        
        TagTextAttachment *attachment = (TagTextAttachment *) value;
        
        if ([attachment.tagID isEqualToString:ID]) {
            tagIndex = range.location;
            *stop = YES;
        }
    }];
    
    NSLog(@"%ld", tagIndex);
    
    // Delete old tag
    [self.textView setSelectedRange:NSMakeRange(tagIndex, 1)];
    [self.textView delete:nil];
    
    // Fetch new tag
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID == %@", ID];
    Tag *newTag = [self.appDelegate.possibleTags filteredArrayUsingPredicate:predicate].firstObject;
    
    // Move cursor into place
    [self.textView setSelectedRange:NSMakeRange(tagIndex, 0)];
    [self insertTag:newTag];
    
    // Return cursor to end
    [self.textView moveToEndOfLine:nil];
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

- (void)toggleShouldCreate {
    self.shouldAutomaticallyCreate = !self.shouldAutomaticallyCreate;
}

- (void)mouseDown:(NSEvent *)event {
    [self insertTag];
    [self.suggestionWindow cancelSuggestions];
    [self.view.window makeFirstResponder:nil];
}

@end
