//
//  CompanyModel.h
//  Data
//
//  Created by 刘晓飞 on 13-5-20.
//  Copyright (c) 2013年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"
@interface CompanyModelBase:LKDAOBase

@end

@interface CompanyModel:LKModelBase
{
    NSString *orgid;//企业号
    NSString *version;//版本号，用于判定是否更新
    NSString *shortName;//简称
    NSString *autoLogin;//自动登录   0自动   1非自动
    NSString *autoRemember;//记住密码   0记住   1不记住
    NSString *password;//密码
    NSString *ex;//附加信息
    NSString *defaultPassword;//成员默认登录密码
}
@property(copy,nonatomic)NSString *shortName;//简称
@property(copy,nonatomic)NSString *orgid;//企业号
@property(copy,nonatomic)NSString *version;//版本号，用于判定是否更新
@property(copy,nonatomic)NSString *autoLogin;//自动登录   0自动   1非自动
@property(copy,nonatomic)NSString *autoRemember;//记住密码   0记住   1不记住
@property(copy,nonatomic)NSString *password;//密码
//以下为修改企业信息用
@property(copy,nonatomic)NSString *fullName;//企业全称
@property(copy,nonatomic)NSString *createrName;//企业创建者名称
@property(copy,nonatomic)NSString *createrphoneNo;//企业创建者固定电话
@property(copy,nonatomic)NSString *ex;//附加信息
@property(copy,nonatomic)NSString *defaultPassword;//成员默认登录密码


@property (nonatomic, copy) NSString *logoName; // 企业logo的名称 图片MD5码

@property (nonatomic, assign) int logoState; // 企业logo的的保存状态 0 本地 1 服务器



@end
