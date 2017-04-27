//
//  UIPlaceHolderTextView.h
//  果动校园
//
//  Created by AnYanbo on 15/1/26.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@class UIPlaceHolderTextView1;

@protocol UIPlaceHolderTextViewDelegate  <NSObject>

@optional

- (BOOL)placeHolderTextViewShouldBeginEditing:(UIPlaceHolderTextView1 *)textView;
- (BOOL)placeHolderTextViewShouldEndEditing:(UIPlaceHolderTextView1 *)textView;

- (void)placeHolderTextViewDidBeginEditing:(UIPlaceHolderTextView1 *)textView;
- (void)placeHolderTextViewDidEndEditing:(UIPlaceHolderTextView1 *)textView;

- (BOOL)placeHolderTextView:(UIPlaceHolderTextView1 *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)placeHolderTextViewDidChange:(UIPlaceHolderTextView1 *)textView;

- (void)placeHolderTextViewDidChangeSelection:(UIPlaceHolderTextView1 *)textView;

@end

@interface UIPlaceHolderTextView1 : UITextView <UITextViewDelegate>
{
    
}
@property (nonatomic, weak) id<UIPlaceHolderTextViewDelegate> delegateEx;
@property (nonatomic, strong)IBInspectable NSString* placeholder;
@property (nonatomic, strong)IBInspectable UIColor* placeholderColor;
@property (nonatomic, strong)IBInspectable UIFont* placeholderFont;
@property (nonatomic,retain)IBInspectable UILabel *placeHolderLabel;

@property (nonatomic,assign)IBInspectable BOOL showPlaceHeader;  //显示提示字，在顶部
@property (nonatomic,assign)IBInspectable NSUInteger MAXContent; //最大内容

@property (nonatomic,assign)IBInspectable BOOL filterEmoji;  //不让输入表情


@end
