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
#import "DetailFoodModel.h"
#import "FoodModel.h"

#define LKSQLText @"text"
#define LKSQLInt @"integer"
#define LKSQLDouble @"float"
#define LKSQLBlob @"blob"
#define LKSQLNull @"null"
#define LKSQLIntPrimaryKey @"integer primary key"


@interface YC_FMDBManager : NSObject
@property (nonatomic, strong) FMDatabase *fmdb;
@property (nonatomic, strong) NSMutableArray * columnNameArr;//存放每一个数据库表的字段名字
@property (nonatomic, strong) NSMutableArray * columnTypeArr;//存放数据库表列类型（int，string。。。。。。）
@property (nonatomic, strong) NSArray * tableNameArr;//存放数据库表名
typedef enum
{
    detailFoodModel = 0,
    foodModel = 1,
}
FSO;
//单例：为了保证整个有且只有一个数据库
+ (YC_FMDBManager *)shareManager;

//增加数据
- (void)insertInfo:(id)model andType:(FSO)type;

//修改数据
//- (void)updataInfo:(PlaceModel *)model andID:(NSInteger)ID;

//查询数据
- (NSArray *)allPersonInfos;

//删除
- (void)deletePersonInfo:(NSString *)name;
@end
