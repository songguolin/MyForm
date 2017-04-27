//
//  UIPlaceHolderTextField.m
//  LimitTextInputDemo
//
//  Created by guolin     song on 2016/12/12.
//  Copyright © 2016年 Marke Jave. All rights reserved.
//

#import "UIPlaceHolderTextField.h"

#import "NSString+Addition.h"

@interface UIPlaceHolderTextField()

@property (nonatomic , strong) LTTextInputLimitManager *limitManager;

@end

@implementation UIPlaceHolderTextField

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
-(void)setShowTitle:(BOOL)showTitle
{
    _showTitle=showTitle;
    if (self.showTitle) {
       
        self.clipsToBounds=NO;
        self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, -10, [UIScreen mainScreen].bounds.size.width-20, 15)];
       
        _titleLabel.font=[UIFont boldSystemFontOfSize:12.f];
        _titleLabel.text=self.placeholder;
        _titleLabel.textColor=[UIColor colorWithWhite:0.6 alpha:1];
        [self addSubview:_titleLabel];

        _titleLabel.hidden=YES;
        
    }
    
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

- (void)config
{
    
    [self addTarget:self action:@selector(TFLimitLength:) forControlEvents:UIControlEventEditingChanged];
    
    self.textLimitType = LTTextLimitTypeLength;
    if (self.textLimitSize==0) {
        [self setTextLimitSize:NSIntegerMax];
    }


    
    
    if (![super delegate] ||
        ([super delegate] && [super delegate] != [self limitManager])) {
        
        [super setDelegate:[self limitManager]];
    }
   
}
-(void)TFLimitLength:(UIPlaceHolderTextField *)textField
{
    
    if (textField.text.length>0) {
         _titleLabel.text=self.placeholder;
        _titleLabel.hidden=NO;
    }
    else
    {
        _titleLabel.hidden=YES;
       
    }
    
    if ([self.delegateEx respondsToSelector:@selector(UIPlaceHolderTextFieldDidChange:)]) {
        return [self.delegateEx UIPlaceHolderTextFieldDidChange:textField];
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

#pragma mark setter
-(void)setTEXT:(NSString *)TEXT
{
    _TEXT=TEXT;
    self.text=TEXT;
    if (TEXT.length>0) {
        _titleLabel.hidden=NO;
    }
    else
    {
        _titleLabel.hidden=YES;
    }
}
-(void)setInputType:(NSInteger)inputType
{
    _inputType=inputType;

    self.textLimitInputType=inputType;

    
}

-(void)setTextLimitSize:(NSInteger)textLimitSize
{
    _textLimitSize=textLimitSize;

}
- (void)setText:(NSString *)text{
    [super setText:text];
    
    [self setCorrect:[LTTextInputLimitManager contentAllowTextInput:self text:text]];
}

- (void)setTextLimitType:(LTTextLimitType)textLimitType{
    
    _textLimitType = textLimitType;

}
-(void)setTextLimitInputType:(LTTextLimitInputType)textLimitInputType
{
    
    _textLimitInputType=textLimitInputType;
    
    
}
@end
