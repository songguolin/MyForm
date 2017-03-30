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
    NSString * identifireCell=@"identifireCell";
    switch (model.formCellViewType) {
        case FormCellViewType_Default:
        {
            return [identifireCell stringByAppendingString:@"_Default"];
        }
            break;
        case FormCellViewType_TF:
        {
            return [identifireCell stringByAppendingString:@"_TF"];
        }
            break;
        case FormCellViewType_TV:
        {
            return [identifireCell stringByAppendingString:@"_TV"];
        }
            break;
            
        default:
            break;
    }
    
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
- (void)setupSubViewsForModel:(FormModel *)model withIndexPath:(NSIndexPath *)indexpath andTableView:(UITableView *)tableView;
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
    
    _formView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    _formView.frame=self.contentView.bounds;
    [self.contentView addSubview:_formView];

}
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

-(void)setupWithModel:(FormModel *)model
{
    self.formModel=model;
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
