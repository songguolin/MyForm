//
//  FormBaseView.m
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "FormBaseView.h"

@interface FormBaseView ()
@property (nonatomic,strong) UIButton * button;
@end
@implementation FormBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init
{
    if (self=[super init]) {
        self.button=[UIButton new];
        self.button.backgroundColor=[UIColor clearColor];
        [self addSubview:self.button];
    }
    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.button.frame=self.bounds;
}
-(void)setupWithModel:(FormModel*)model
{
    self.model=model;
    if (self.model.formCellViewType==FormCellViewType_Default) {
        if (model.content!=nil) {
            [self.button setTitle:model.content forState:UIControlStateNormal];
        }
        
    }
}
@end
