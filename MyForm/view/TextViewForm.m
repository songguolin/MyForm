//
//  TextViewForm.m
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "TextViewForm.h"
#import "UIPlaceHolderTextView1.h"

@interface TextViewForm ()<UITextViewDelegate>
@property (nonatomic,strong) UIPlaceHolderTextView1 * textView;
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
        _textView = [[UIPlaceHolderTextView1 alloc] init];
        _textView.delegate = self;
        _textView.backgroundColor=[UIColor whiteColor];
        
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:18.0f];
        
        _textView.scrollEnabled = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;


        [self addSubview:self.textView];
        

        
    }
    return self;
}


-(void)setupWithModel:(FormModel*)model
{
    
    [super setupWithModel:model];

    CGRect cellFrame = CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width-20, 40);

    _textView.frame=cellFrame;
    
    
    
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
    [self updateHeight];
}

-(void)updateHeight
{
    

    CGFloat  height= [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height;
    
    self.newheight=height+20;
   
    
    if (self.heightBlock) {
        self.heightBlock(self.newheight);
    }

    
    
 
}


@end
