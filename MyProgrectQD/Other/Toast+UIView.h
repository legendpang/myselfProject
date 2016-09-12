//
//  Toast+UIView.h
//  仿android系统Toast效果
//
//  Created by 晓飞 刘 on 13-1-8.
//  Copyright (c) 2013年 青岛英特沃克网络科技有限公司. All rights reserved.
//

//------------华丽的分割线------------//
//在需要用的视图#import "Toast+UIView.h"
//直接使用[self.view xxxx]即可调用
//补充一句：---
//------------华丽的分割线------------//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Toast)

//
//  最普通的Toast
//
//  返回值：void    内容：message
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)makeToast:(NSString *)message;

//
//  可以调节持续时间和位置的Toast
//
//  返回值：void    内容：message  持续时间：duration   位置：position
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position;

//
//  可以调节持续时间、位置和标题的Toast
//
//  返回值：void    内容：message  持续时间：duration   位置：position    标题：title
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title;

//
//  可以调节持续时间、位置、标题和图片的Toast
//
//  返回值：void    内容：message  持续时间：duration   位置：position    标题：title     图片：image
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title image:(UIImage *)image;

//
//  可以调节持续时间、位置和图片的Toast
//
//  返回值：void    内容：message  持续时间：duration   位置：position    图片：image
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position image:(UIImage *)image;

//
//  创建Activity
//
//  返回值：void
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)makeToastActivity;

//
//  可设置位置的Activity
//
//  返回值：void    位置：position
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)makeToastActivity:(id)position;

//
//  隐藏Activity
//
//  返回值：void
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)hideToastActivity;

//
//  根据图片创建Toast
//
//  返回值：void    图片：toast
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)showToast:(UIView *)toast;

//
//  根据图片创建Toast，可设置持续时间和位置
//
//  返回值：void    图片：toast    持续时间：duration     位置：position
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point;

//
//  专门为超时的定时任务而写
//
//  返回值：void
//
//  Created by 晓飞 刘 on 13-1-8.
//
- (void)hideToastActivityAndAppearNotice;
/**
 *  专门为超时的定时任务而写，并添加下方提示文字
 *  字数不能过多
 */
- (void)hideToastActivityAndAppearNoticeWithTitle:(NSString *)title;

@end
