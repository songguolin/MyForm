//
//  UIPlaceHolderTextField.h
//  果动校园
//
//  Created by     songguolin on 16/1/27.
//  Copyright © 2016年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTTextInputLimitManager.h"
IB_DESIGNABLE

typedef NS_ENUM(NSInteger,limitType)
{
    TextLimitInputTypeNone,          // 没有限制,0
    TextLimitInputTypeEnglish,       // 纯英文,1
    TextLimitInputTypeChinese,       // 纯中文,2
    TextLimitInputTypeNumber,        // 纯数字,3
    TextLimitInputTypeFloatNumber,   // 小数,4
    TextLimitInputTypeTelephoneNumber,  // 手机号码,5
    TextLimitInputTypeEmail,            // 邮箱,6
    TextLimitInputTypeEnglishOrChinese, // 中英混合,7
    TextLimitInputTypeEnglishOrNumber,  // 英文和数字混合,8
    TextLimitInputTypeEnglishAndChinese, // 中英混合,9
    TextLimitInputTypeEnglishAndNumber,  // 英文和数字混合,10
};

@class UIPlaceHolderTextField;

@protocol UIPlaceHolderTextFieldDelegate  <NSObject>

@optional

//代理
- (void)UIPlaceHolderTextFieldDidChange:(UIPlaceHolderTextField *)textField;


@end

//这个会造成 UITextField的代理执行两次
@interface UIPlaceHolderTextField : UITextField<LTTextInput>


@property (nonatomic, weak) id<UIPlaceHolderTextFieldDelegate> delegateEx;

//可xib操作

@property (nonatomic,assign)IBInspectable NSInteger inputType;
@property (nonatomic,assign)IBInspectable BOOL showTitle;

//针对于 有提示的输入框
@property (nonatomic,strong)IBInspectable UILabel * titleLabel;
//输入框内容，当直接赋值，不会触发事件
@property (nonatomic,copy) NSString * TEXT;

@property (nonatomic, assign) IBInspectable LTTextLimitInputType textLimitInputType;   // Default is LTTextLimitInputTypeNone.
@property (nonatomic, assign) IBInspectable LTTextLimitType textLimitType;      // Default is TextLimitTypeNone.
@property (nonatomic, assign)IBInspectable NSInteger textLimitSize;          // If textLimitType is not TextLimitTypeNone, default is NSIntegerMax, or is 0.
@property (nonatomic, assign)IBInspectable NSInteger minusSize;

@property (nonatomic, assign, getter=isCorrect) BOOL correct;

@end
