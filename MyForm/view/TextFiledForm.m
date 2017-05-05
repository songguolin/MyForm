//
//  textFieldForm.m
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "TextFiledForm.h"
#import "UIPlaceHolderTextField.h"
#import "Masonry.h"
@interface TextFiledForm ()<UITextFieldDelegate,UIPlaceHolderTextFieldDelegate>
@property (strong, nonatomic)  UIPlaceHolderTextField *textField;

@property (nonatomic,copy) NSString *currentString;

@end
@implementation TextFiledForm

+(instancetype)creat
{
    TextFiledForm * view=[ TextFiledForm new];
    return view;
}
-(id)init
{
    if (self=[super init]) {
        self.textField=[UIPlaceHolderTextField new];

        self.textField.font=[UIFont systemFontOfSize:14.f];

        self.textField.delegateEx=self;
        self.textField.delegate=self;
        [self addSubview:self.textField];
        

        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).mas_offset(10);
            make.right.equalTo(self).mas_offset(-10);
            make.top.equalTo(self).mas_offset(20);
        }];
    }
    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];


}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.textField.delegate=self;
}
-(void)setupWithModel:(FormModel*)model
{
    
    [super setupWithModel:model];
  
    self.textField.text=model.content;
    self.textField.placeholder=model.placeholder;
 
    [self configTFWithModel:model];
}
-(void)configTFWithModel:(FormModel*)model
{
    if (model.formTextFieldType==FormTextFieldType_Date) {
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        [self.textField addTarget:self action:@selector(formatDate) forControlEvents:UIControlEventEditingChanged];
    }
    else if (model.formTextFieldType==FormTextFieldType_Password) {
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.keyboardType = UIKeyboardTypeDefault;
        self.textField.secureTextEntry = YES;
        
    }
    else if (model.formTextFieldType==FormTextFieldType_URL) {
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.keyboardType = UIKeyboardTypeURL;
    }
    else if (model.formTextFieldType==FormTextFieldType_NonEditable) {
        self.textField.enabled = NO;
    }
    else {
        NSUInteger type=model.formTextFieldType;
        self.textField.textLimitInputType=type;
    }
}
- (void)formatDate {

    //说明是删除
    if (self.currentString.length>self.textField.text.length) {
        self.currentString = self.textField.text;
        
        //判断 第6位字符，大于1
        if (self.currentString.length == 6) {
            
            NSString *strippedValue = [self.currentString stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.currentString.length)];
            NSString * month=[strippedValue substringWithRange:NSMakeRange(4, 1)];
            if ([month integerValue]==0) {
                NSString * year=[strippedValue substringToIndex:4];
                self.textField.text=year;
                self.currentString = self.textField.text;
            }
        }
    }
    else
    {
        self.currentString = self.textField.text;
        NSString *strippedValue = [self.currentString stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.currentString.length)];
        
        // Date formatting will follow the format MM/DD/YYYY
        NSString *formattedString;

        //判断 第5位字符，大于1
        if (strippedValue.length == 5) {
            NSString * month=[strippedValue substringWithRange:NSMakeRange(4, 1)];
            if ([month integerValue]>1) {
                month=[NSString stringWithFormat:@"0%@",month];
                strippedValue=[NSString stringWithFormat:@"%@%@",[strippedValue substringToIndex:4],month];
                
            }
        }
        //判断 第6位字符，大于2
        if (strippedValue.length == 6) {
            NSString * month=[strippedValue substringWithRange:NSMakeRange(4, 1)];
            if ([month integerValue]==1)
            {
                NSString * month1=[strippedValue substringWithRange:NSMakeRange(5, 1)];
                if ([month1 integerValue]>2) {
                    strippedValue=[strippedValue substringToIndex:5];
                }
            }
            
        }
        
        //判断 第7位字符，大于3

        if (strippedValue.length == 8) {
            NSString * day=[strippedValue substringWithRange:NSMakeRange(6, 1)];
            if ([day integerValue]==3)
            {
                NSString * month1=[strippedValue substringWithRange:NSMakeRange(7, 1)];
                if ([month1 integerValue]>1) {
                    strippedValue=[strippedValue substringToIndex:7];
                }
            }
            if ([day integerValue]>3)
            {
                strippedValue=[strippedValue substringToIndex:7];
            }
            
        }

        
        
        
        
        
        
        if (strippedValue.length == 0) {
            formattedString = @"";
        }
        else if (strippedValue.length < 4) {
            formattedString = strippedValue;
        }
        else if (strippedValue.length == 4) {
            formattedString = [NSString stringWithFormat:@"%@-", strippedValue];
        }
        else if (strippedValue.length <= 6) {
            formattedString = [NSString stringWithFormat:@"%@-%@", [strippedValue substringToIndex:4], [strippedValue substringFromIndex:4]] ;
        }
        else if (strippedValue.length <= 8) {
            NSString * year=[strippedValue substringToIndex:4];
            NSString * month=[strippedValue substringWithRange:NSMakeRange(4, 2)];
            NSString * day=[strippedValue substringFromIndex:6];
            
            formattedString = [NSString stringWithFormat:@"%@-%@-%@", year, month, day] ;
        }
        else {
            formattedString = [self.currentString substringToIndex:10];
        }
 
        self.textField.TEXT = formattedString;
        self.currentString = self.textField.text;
    }
   
}
    
#pragma mark 
- (void)UIPlaceHolderTextFieldDidChange:(UIPlaceHolderTextField *)textField
{
    self.placeholderLabel.hidden=textField.text.length>0?NO:YES;
}
    
#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.content=textField.text;
}
@end
