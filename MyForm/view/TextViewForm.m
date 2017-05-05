//
//  TextViewForm.m
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "TextViewForm.h"
#import "LTPlaceholderTextView.h"
#import "Masonry.h"
@interface TextViewForm ()<UITextViewDelegate>
@property (nonatomic,strong) LTPlaceholderTextView * textView;
@property (nonatomic,assign) CGFloat newheight;

@end
@implementation TextViewForm

+(instancetype)creat
{
    TextViewForm * view=[[TextViewForm alloc] init];
    return view;
}
-(id)init
{
    if (self=[super init]) {
        _textView = [[LTPlaceholderTextView alloc] init];
        _textView.delegate = self;


        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:14.0f];
        
        _textView.scrollEnabled = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;



        [self addSubview:self.textView];
        
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).mas_offset(10);
            make.right.equalTo(self).mas_offset(-10);
            make.top.equalTo(self).mas_equalTo(20);
//            make.height.mas_equalTo(40);
        }];

        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];

  
}

-(void)setupWithModel:(FormModel*)model
{
    
    [super setupWithModel:model];
 
    
 
    if (model.content!=nil) {
        self.textView.text=model.content;
        [self updateHeight];
    }
    if (model.placeholder!=nil) {
        self.textView.placeholder=model.placeholder;
    }
    
    
    
}

#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.placeholderLabel.hidden=textView.text.length>0?NO:YES;
    self.model.content=textView.text;
    [self updateHeight];
}

-(void)updateHeight
{
    

    CGFloat  height= [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height;
    
    self.newheight=height+20;

    //这样写 cell会跳动
//    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
    

    self.textView.frame=CGRectMake(10, 20, self.bounds.size.width-20, height);
    
    if (self.heightBlock) {
        self.heightBlock(self.newheight);
    }
    
}


@end
