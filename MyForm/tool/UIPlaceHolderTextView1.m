//
//  UIPlaceHolderTextView.m
//  果动校园
//
//  Created by AnYanbo on 15/1/26.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "UIPlaceHolderTextView1.h"
@interface UIPlaceHolderTextView1()

@end
@implementation UIPlaceHolderTextView1

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {

        [self _init];
    }
    
    return self;
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        
        [self _init];
    }
    
    return self;
}
-(void)_init
{
    [self setPlaceholder:@"请输入内容..."];
    [self setPlaceholderColor:[UIColor colorWithWhite:0.8 alpha:1]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    self.delegate = self;
    
    self.MAXContent=10000;
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=placeholder;
    self.placeHolderLabel.text=placeholder;
}
-(void)setMAXContent:(NSUInteger)MAXContent
{
    _MAXContent=MAXContent;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChanged:(NSNotification *)notification
{
    if ([[self placeholder] length] == 0)
    {
        return;
    }
   
    if ([[self text] length] == 0)
    {
       
        [[self viewWithTag:999] setAlpha:1];
//        self.topLabel.hidden=NO;

    }
    else
    {
            [[self viewWithTag:999] setAlpha:0];
//         self.topLabel.hidden=self.showPlaceHeader;
    }
    
//    self.text=[NSString filterEmoji:self.text];
    if (self.text.length>self.MAXContent) {
        self.text=[self.text substringToIndex:self.MAXContent];
    }
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}


- (void)drawRect:(CGRect)rect
{
    
    if ([[self placeholder] length] > 0)
    {
        
        if (_placeHolderLabel == nil)
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, self.bounds.size.width - 16, 15)];
            
            _placeHolderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _placeHolderLabel.numberOfLines = 0;
            if (self.placeholderFont != nil)
            {
                _placeHolderLabel.font = self.placeholderFont;
            }
            else
            {
                _placeHolderLabel.font = self.font;
            }
            _placeHolderLabel.backgroundColor=[UIColor clearColor];
            
            _placeHolderLabel.textColor = self.placeholderColor;
            
            _placeHolderLabel.alpha = 0;
            
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
        
        
        
       
      
    }
    
    if ([[self text] length] == 0 && [[self placeholder] length] > 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    if ([self.delegateEx respondsToSelector:@selector(placeHolderTextViewShouldBeginEditing:)])
    {
        return [self.delegateEx placeHolderTextViewShouldBeginEditing:(UIPlaceHolderTextView1*)textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.delegateEx respondsToSelector:@selector(placeHolderTextViewShouldEndEditing:)])
    {
        return [self.delegateEx placeHolderTextViewShouldEndEditing:(UIPlaceHolderTextView1*)textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.delegateEx respondsToSelector:@selector(placeHolderTextViewDidBeginEditing:)])
    {
        [self.delegateEx placeHolderTextViewDidBeginEditing:(UIPlaceHolderTextView1*)textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
   
    
    if ([self.delegateEx respondsToSelector:@selector(placeHolderTextViewDidEndEditing:)])
    {
        [self.delegateEx placeHolderTextViewDidEndEditing:(UIPlaceHolderTextView1*)textView];
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    
    if (self.filterEmoji) {
        // 不让输入表情
        if ([textView isFirstResponder]) {
            if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
                return NO;
            }
        }
        
    }


    
    //如果没实现这个方法，点击换行，响应就注销
    if ([self.delegateEx respondsToSelector:@selector(placeHolderTextView:shouldChangeTextInRange:replacementText:)])
    {
        return  [self.delegateEx placeHolderTextView:(UIPlaceHolderTextView1*)textView shouldChangeTextInRange:range replacementText:text];
    }
    else
    {
        if (range.length == 1)     // 回删
        {
            return YES;
        }
        else
        {
            // 超过长度限制
            if ([textView.text length] > self.MAXContent)
            {
                
                return NO;
            }
        }
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if ([self.delegateEx respondsToSelector:@selector(placeHolderTextViewDidChange:)])
    {
        [self.delegateEx placeHolderTextViewDidChange:(UIPlaceHolderTextView1*)textView];
    }
    else
    {
        if (textView.text.length>self.MAXContent+1) {
           
        }
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([self.delegateEx respondsToSelector:@selector(placeHolderTextViewDidChangeSelection:)])
    {
        [self.delegateEx placeHolderTextViewDidChangeSelection:(UIPlaceHolderTextView1*)textView];
    }
}

@end
