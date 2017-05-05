//
//  LTLimitTextField.m
//  LimitTextInput
//
//  Created by Marike Jave on 4/11/13.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "LTLimitTextField.h"
#import "NSString+Addition.h"

@interface LTLimitTextField()

@property (nonatomic , strong) LTTextInputLimitManager *limitManager;

@end

@implementation LTLimitTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self config];
}

- (instancetype)init{
    self = [super init];
    
    if (self) {
        
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self config];
    }
    return self;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate{
    
    if (![super delegate] ||
        ([super delegate] && [super delegate] != [self limitManager])) {
        
        [super setDelegate:[self limitManager]];
    }
    
    [[self limitManager] setDelegate:delegate];
}

- (id<UITextFieldDelegate>)delegate{
    
    return [[self limitManager] delegate];
}

- (LTTextInputLimitManager *)limitManager{
    
    if (!_limitManager) {
        
        _limitManager = [[LTTextInputLimitManager alloc] init];
        [_limitManager setTextInput:self];
    }
    return _limitManager;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    
    [self setCorrect:[LTTextInputLimitManager contentAllowTextInput:self text:text]];
}

- (void)setTextLimitType:(LTTextLimitType)textLimitType{
    _textLimitType = textLimitType;
    
    [self config];
}

- (void)config;{
    
    [self setTextLimitSize:NSIntegerMax];
    
    if (![super delegate] ||
        ([super delegate] && [super delegate] != [self limitManager])) {
        
        [super setDelegate:[self limitManager]];
    }
}

- (void)unmarkText;{
    
    
    if ([self textLimitType] != LTTextLimitTypeNone) {
        UITextRange *markedTextRange = [self markedTextRange];
        NSString *originMarkedText = [self textInRange:markedTextRange];
        NSInteger markedStartOffset = [self offsetFromPosition:[self beginningOfDocument] toPosition:[markedTextRange start]];
        // default is marked text
        NSRange replaceRange = NSMakeRange(markedStartOffset, [originMarkedText length]);
        if ([[self limitManager] respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            if ([[self limitManager] textField:self shouldChangeCharactersInRange:replaceRange replacementString:originMarkedText]) {
                [super unmarkText];
            }
        }
    }
    else{
        [super unmarkText];
    }
}

- (void)setMarkedText:(NSString *)markedText selectedRange:(NSRange)selectedRange;{
    
    
    if ([self textLimitType] != LTTextLimitTypeNone) {
        UITextRange *markedTextRange = [self markedTextRange];
        NSString *originMarkedText = [self textInRange:markedTextRange];
        NSInteger markedStartOffset = [self offsetFromPosition:[self beginningOfDocument] toPosition:[markedTextRange start]];
        NSInteger markedEndOffset = [self offsetFromPosition:[self beginningOfDocument] toPosition:[markedTextRange end]];
        // default is marked text
        NSString *replacement = markedText;
        NSRange replaceRange = NSMakeRange(markedStartOffset, [originMarkedText length]);
        // append marked text
        if (selectedRange.location > originMarkedText.length) {
            
            replacement = [[markedText stringByReplacingOccurrencesOfString:originMarkedText withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
            replaceRange = NSMakeRange(markedEndOffset, 0);
        }
        if ([[self limitManager] respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            if ([[self limitManager] textField:self shouldChangeCharactersInRange:replaceRange replacementString:replacement]) {
                [super setMarkedText:markedText selectedRange:selectedRange];
            }
        }
    }
    else{
        [super setMarkedText:markedText selectedRange:selectedRange];
    }
}

@end
