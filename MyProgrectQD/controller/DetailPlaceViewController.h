//
//  DetailPlaceViewController.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "PlaceModel.h"
typedef void (^sendBlock) (NSArray *arr);

@interface DetailPlaceViewController : RootViewController

@property(nonatomic,strong)NSString * xid;
@property(nonatomic,strong)PlaceModel * myapp;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)sendBlock myBlock;
@end
