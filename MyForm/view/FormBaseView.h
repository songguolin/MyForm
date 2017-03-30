//
//  FormBaseView.h
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormModel.h"
@interface FormBaseView : UIView

@property (nonatomic,strong) FormModel * model;
-(void)setupWithModel:(FormModel*)model;
@end
