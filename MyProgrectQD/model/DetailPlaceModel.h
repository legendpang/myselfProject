//
//  DetailPlaceModel.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailPlaceModel : NSObject

@property(nonatomic,strong)NSArray * images;
@property(nonatomic,strong)NSString * introduction;
@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)NSString * phone;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,strong)NSString * score;

@property(nonatomic,strong)NSString * map_x;
@property(nonatomic,strong)NSString * map_y;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
