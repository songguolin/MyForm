//
//  FormModel.m
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "FormModel.h"

@implementation FormModel
-(id)init
{
    if (self=[super init]) {
        self.formCellViewType=FormCellViewType_Default;
        self.cellHeight=60.f;
    }
    return self;
}
@end
