# MYForm
[![Version](https://img.shields.io/cocoapods/v/MYForm.svg?style=flat)](http://cocoadocs.org/docsets/MYForm)
[![License](https://img.shields.io/cocoapods/l/MYForm.svg?style=flat)](http://cocoadocs.org/docsets/MYForm)
[![Platform](https://img.shields.io/cocoapods/p/MYForm.svg?style=flat)](http://cocoadocs.org/docsets/MYForm)
![Language](https://img.shields.io/badge/Language-%20Objective%20C%20-blue.svg)
### 应用截图
![image](https://github.com/songguolin/MyForm/blob/master/009657ED-2A93-469D-A3D9-FC1706E40143.jpeg)
### 框架整体介绍
* 该框架为一个能够快速构建信息表单的一款工具。
* 支持cocoapod，使用 pod 'MyForm'。


### 框架支持与框架依赖
* iOS7.0
* (采用arc模式)
* XCode8.0


### 注意点
```objc
模型驱动视图：模型定义
FormModel * model1=[FormModel new];
model1.cellHeight=60.f;
model1.placeholder=[self getPlaceholderWithType:i];
model1.content=nil;
model1.formCellViewType=FormCellViewType_TF;
model1.formTextFieldType=FormTextFieldType_English;
model1.showTitle=YES;



//自定义cell中的内容
-(FormBaseView*)tableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
   //自定义，只要继承自FormBaseView 即可
   //return [TextFiledForm creat];

   //nil代表自动生成
     return nil;
}
```

