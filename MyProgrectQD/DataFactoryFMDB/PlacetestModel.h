//
//  PlacetestModel.h
//  MyProgrectQD
//
//  Created by Dalang on 16/8/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"
@interface PlacetestModelBase : LKDAOBase

@end

@interface PlacetestModel :LKModelBase
@property (nonatomic,strong)NSString * placeName;
@property (nonatomic,strong)NSString * placeId;
@property (nonatomic,strong)NSString * placePrice;
@end