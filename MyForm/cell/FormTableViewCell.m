//
//  FormTableViewCell.m
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import "FormTableViewCell.h"

#import "TextViewForm.h"
#import "TextFiledForm.h"
#import "Masonry.h"
@interface FormTableViewCell ()
{
    FormBaseView *_formView;
}
@end
@implementation FormTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//cell的标示
+ (NSString *)cellIdentifierForMessageModel:(FormModel *)model
{

    switch (model.formCellViewType) {
        case FormCellViewType_Default:
        {

            static NSString * identifireCell=@"identifireCell_Default";
            return identifireCell;
        }
            break;
        case FormCellViewType_TF:
        {
            
            static NSString * identifireCell=@"identifireCell_Default";
            return identifireCell;
        }
            break;
        case FormCellViewType_TV:
        {
           
            static NSString * identifireCell=@"identifireCell_Default";
            return identifireCell;
        }
            break;
            
        default:
            break;
    }
    
    static NSString * identifireCell=@"identifireCell";
    return identifireCell;
}
//第一次创建，没有cell
- (id)initWithFormModel:(FormModel *)model reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexpath tableView:(UITableView *)tableView
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
         [self setupSubViewsForModel:model withIndexPath:indexpath andTableView:tableView];
       
    }
    return self;
}

//设置视图
- (void)setupSubViewsForModel:(FormModel *)model withIndexPath:(NSIndexPath *)indexpath andTableView:(UITableView *)tableView
{
    self.expandableTableView=tableView;
    self.formModel=model;
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(FormTableViewDelegate)]) {
        
        id<FormTableViewDelegate> delegate = (id<FormTableViewDelegate>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
        if ([delegate respondsToSelector:@selector(tableView:atIndexPath:)]) {
           _formView= [delegate tableView:self.expandableTableView
                    atIndexPath:indexPath];
            if (_formView!=nil) {
                [self.contentView addSubview:_formView];
                return;
            }

        }
    }
    
    
    _formView=[self formViewForMessageModel:model];
    [_formView setupWithModel:model];
    
    [self.contentView addSubview:_formView];
    [_formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.bottom.equalTo(self.contentView);
    }];
}
//根据模型创建不同的内容控件
- (FormBaseView *)formViewForMessageModel:(FormModel *)model
{
    switch (model.formCellViewType) {
        case FormCellViewType_Default:
        {
            return [FormBaseView new];
        }
            break;
        case FormCellViewType_TF:
        {
            return [TextFiledForm creat];
        }
            break;
        case FormCellViewType_TV:
        {
           
            TextViewForm * view=[TextViewForm creat];
            
            __weak typeof(self) weakSelf=self;
            view.heightBlock=^(CGFloat height){
                [weakSelf updateFormCellHeight:height];
            };
            return view;
        }
            break;
            
        default:
            break;
    }

    
    return nil;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
  
}

#pragma mark 负责内容的
-(void)setupWithModel:(FormModel *)model
{
    self.formModel=model;
    
    //这个是每次滑动都会调用，避免cell重用
    [_formView setupWithModel:model];
}
-(void)updateFormCellHeight:(CGFloat)newHeight
{
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(FormTableViewDelegate)]) {
        
        id<FormTableViewDelegate> delegate = (id<FormTableViewDelegate>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
       
        CGFloat oldHeight = [delegate tableView:self.expandableTableView heightForRowAtIndexPath:indexPath];
        if (fabs(newHeight - oldHeight) > 0.01) {
            self.formModel.cellHeight=newHeight;
            
            // refresh the table without closing the keyboard
            [self.expandableTableView beginUpdates];
            [self.expandableTableView endUpdates];
        }
    }

}
@end
