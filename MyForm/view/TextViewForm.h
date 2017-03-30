//
//  TextViewForm.h
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "FormBaseView.h"

typedef void (^TextViewFormHeightBlock)(CGFloat height);
@interface TextViewForm : FormBaseView

@property (nonatomic,copy) TextViewFormHeightBlock heightBlock;
+(instancetype)creat;
@end
