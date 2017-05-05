//
//  FormBaseView.m
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "FormBaseView.h"

@interface FormBaseView ()
    
//显示 文本内容的
@property (nonatomic,strong) UILabel * defaultLabel;

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
        
        
        }
    
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.defaultLabel.frame=self.bounds;
    self.placeholderLabel.frame=CGRectMake(10, 5, self.bounds.size.width, 15);
}
    
-(void)setupWithModel:(FormModel*)model
{
    self.model=model;
    
    //加载普通文本内容
    if (self.model.formCellViewType==FormCellViewType_Default) {
        if (self.defaultLabel==nil) {
            self.defaultLabel=[UILabel new];
            self.defaultLabel.backgroundColor=[UIColor clearColor];
            
            [self addSubview:self.defaultLabel];
        }
        if (model.content!=nil) {
            self.defaultLabel.text=model.content;
        }
        
    }
    
    
    //加载默认提示字
    if (model.showTitle) {
        if (self.placeholderLabel==nil) {
            self.placeholderLabel=[UILabel new];
            self.placeholderLabel.font=[UIFont boldSystemFontOfSize:12];
            self.placeholderLabel.textColor=[UIColor colorWithWhite:0.6 alpha:1];
            self.placeholderLabel.backgroundColor=[UIColor clearColor];
            
            [self addSubview:self.placeholderLabel];
        }
        self.placeholderLabel.text=model.placeholder;
    }
    
    //每次都要充值提示字
    self.placeholderLabel.hidden=model.content==nil?YES:NO;
    

}
@end
