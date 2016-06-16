//
//  SecondDetailModel.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondDetailModel : NSObject

@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * content;
@property(nonatomic,strong)NSString * regtime;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
