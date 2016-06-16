//
//  YC_FMDBManager.h
//  Day06-FMDB-封装
//
//  Created by 潘颖超 on 15/9/26.
//  Copyright © 2015年 Meakelra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#import "PlaceModel.h"
@interface YC_FMDBManager : NSObject

@property (nonatomic, strong) FMDatabase *fmdb;

//单例：为了保证整个有且只有一个数据库
+ (YC_FMDBManager *)shareManager;

//增加数据
- (void)insertInfo:(PlaceModel *)model andID:(NSInteger)ID;

//修改数据
//- (void)updataInfo:(PlaceModel *)model andID:(NSInteger)ID;

//查询数据
- (NSArray *)allPersonInfos;

//删除
- (void)deletePersonInfo:(NSString *)name;
@end
