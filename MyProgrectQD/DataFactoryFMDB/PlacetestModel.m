//
//  PlacetestModel.m
//  MyProgrectQD
//
//  Created by Dalang on 16/8/31.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "PlacetestModel.h"
@implementation PlacetestModelBase
+(Class)getBindingModelClass
{
    return [PlacetestModel class];
}

const static NSString* tablename = @"PlaceTest";
+(const NSString *)getTableName
{
    return tablename;
}

@end
@implementation PlacetestModel
-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"placeId";//主健
    }
    return self;
}
@end
