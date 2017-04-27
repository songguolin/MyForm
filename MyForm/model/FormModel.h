//
//  FormModel.h
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//输入框类容类型
typedef NS_ENUM(NSInteger,FormTextFieldType)
{
    FormTextFieldType_Default=0,          // 没有限制,0
    FormTextFieldType_English,       // 纯英文,1
    FormTextFieldType_Chinese,       // 纯中文,2
    FormTextFieldType_Number,        // 纯数字,3
    FormTextFieldType_FloatNumber,   // 小数,4
    FormTextFieldType_TelephoneNumber,  // 手机号码,5
    FormTextFieldType_Email,            // 邮箱,6
    FormTextFieldType_EnglishOrChinese, // 中英混合,7
    FormTextFieldType_EnglishOrNumber,  // 英文和数字混合,8
    FormTextFieldType_EnglishAndChinese, // 中英混合,9
    FormTextFieldType_EnglishAndNumber,  // 英文和数字混合,10
    
    FormTextFieldType_Date,                //日期 11
    FormTextFieldType_Password,             //密码 12
    FormTextFieldType_URL,                  //url 13
    FormTextFieldType_NonEditable            //不可点击 14
};


//视图类型
typedef NS_ENUM(NSUInteger,FormCellViewType) {
    FormCellViewType_Default=0,
    FormCellViewType_TF,
    FormCellViewType_TV,
    
};
@interface FormModel : NSObject


//必须的
@property (nonatomic,assign) FormCellViewType formCellViewType;
@property (nonatomic,assign) CGFloat cellHeight;

//可选的的设置
@property (nonatomic,assign) FormTextFieldType formTextFieldType;

//默认字
@property (nonatomic,copy) NSString * placeholder;
//是否显示标题-即输入内容后，placeholder在内容上方显示
@property (nonatomic,assign) BOOL showTitle;
//内容
@property (nonatomic,copy) NSString * content;
@end
