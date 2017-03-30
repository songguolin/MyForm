//
//  textFieldForm.m
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "TextFiledForm.h"
#import "UIPlaceHolderTextField.h"
@interface TextFiledForm ()<UITextFieldDelegate>
@property (strong, nonatomic)  UIPlaceHolderTextField *textField;

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
        [self addSubview:self.textField];
        
    }
    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textField.frame=CGRectMake(10, 0, self.bounds.size.width-15, self.bounds.size.height);
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

    
    NSString *currentString = self.textField.text;
    NSString *strippedValue = [currentString stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, currentString.length)];
    
    // Date formatting will follow the format MM/DD/YYYY
    NSString *formattedString;
    if (strippedValue.length == 0) {
        formattedString = @"";
    }
    else if (strippedValue.length < 2) {
        formattedString = strippedValue;
    }
    else if (strippedValue.length == 2) {
        formattedString = [NSString stringWithFormat:@"%@-", strippedValue];
    }
    else if (strippedValue.length <= 4) {
        formattedString = [NSString stringWithFormat:@"%@-%@", [strippedValue substringToIndex:2], [strippedValue substringFromIndex:2]] ;
    }
    else if (strippedValue.length <= 8) {
        formattedString = [NSString stringWithFormat:@"%@-%@-%@", [strippedValue substringToIndex:2], [strippedValue substringWithRange:NSMakeRange(2, 2)], [strippedValue substringFromIndex:4]] ;
    }
    else {
        formattedString = currentString;
    }
    
    self.textField.text = formattedString;
}

@end
