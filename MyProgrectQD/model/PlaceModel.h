//
//  PlaceModel.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceModel : NSObject
//景点
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * characteristic;
@property(nonatomic,strong)NSString * image;
@property(nonatomic,strong)NSString * distance;
@property(nonatomic,strong)NSString * score;
@property(nonatomic,strong)NSString * cid;
@property(nonatomic,strong)NSString * iId;

//历史
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * des;
@property(nonatomic,strong)NSString * iid;
//美食

@property(nonatomic,strong)NSString * tag;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
