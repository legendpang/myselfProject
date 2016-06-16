//
//  DetailFoodModel.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/11/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailFoodModel : NSObject

@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)NSString * phone;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * money;
@property(nonatomic,strong)NSArray * images;

@property(nonatomic,strong)NSString * map_x;
@property(nonatomic,strong)NSString * map_y;


-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
