//
//  MyNavigationBar.h
//  MyProgrectQD
//
//  Created by Dalang on 16/9/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyNavigationDelegate <NSObject>
@optional

//返回按钮方法
-(void)myNavigationGoback;

@end

@interface MyNavigationBar : UIView
-(instancetype)initWithTitle:(NSString *)title withColor:(UIColor *)color;
-(void)setGoBackButton;

@property (nonatomic,assign)id<MyNavigationDelegate>delegate;
@end
