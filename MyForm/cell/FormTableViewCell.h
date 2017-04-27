//
//  FormTableViewCell.h
//  MyForm
//
//  Created by guolin     song on 2017/3/29.
//  Copyright © 2017年 eastraycloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormBaseView.h"
@protocol FormTableViewDelegate <UITableViewDelegate, UITextViewDelegate>

@optional
-(FormBaseView *)tableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
@interface FormTableViewCell : UITableViewCell

//这个是关联的tableVIew，注意，一定要关联
@property (nonatomic, weak) UITableView *expandableTableView;
@property (nonatomic, strong) FormModel * formModel;

//cell的标示
+ (NSString *)cellIdentifierForMessageModel:(FormModel *)model;
//第一次创建，没有cell
- (id)initWithFormModel:(FormModel *)model reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexpath tableView:(UITableView *)tableView;
//设置视图
- (void)setupSubViewsForModel:(FormModel *)model withIndexPath:(NSIndexPath *)indexpath andTableView:(UITableView *)tableView;


//设置视图内容
-(void)setupWithModel:(FormModel *)model ;

//改变高度
-(void)updateFormCellHeight:(CGFloat)newHeight;

@end
