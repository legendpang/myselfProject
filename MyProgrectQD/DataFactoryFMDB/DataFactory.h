//
//  DataFactory.h
//
//
//  Created by 刘晓飞 on 13-5-20.
//  Copyright (c) 2013年 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SandboxFile.h"
#import "FMDatabaseQueue.h"
#import "CompanyModel.h"
#import "PlacetestModel.h"
#define GetDataBasePath [SandboxFile GetPathForDocuments:@"UMCall.db" inDir:@"DataBase"]

@interface DataFactory : NSObject
@property(retain,nonatomic)id classValues;
@property(retain,nonatomic) FMDatabaseQueue* queue;
typedef enum
{
    company,
    placeTest,
}
FSO;//这个是枚举是区别不同的实体,我这边就写一个test;
+(DataFactory *)shardDataFactory;
//是否存在数据库
-(BOOL)IsDataBase;
//创建数据库
-(void)CreateDataBase;
//创建表
-(void)CreateTable;
//添加数据
-(void)insertToDB:(id)Model Classtype:(FSO)type;
-(BOOL)syncInsertToDB:(id)Model Classtype:(FSO)type;

//修改数据
-(void)updateToDB:(id)Model Classtype:(FSO)type;
-(BOOL)syncUpdateToDB:(id)Model Classtype:(FSO)type;
//批量修改数据
-(void)syncBatchUpdateToDB:(NSArray *)dataArray Classtype:(FSO)type;

//删除单条数据
-(void)deleteToDB:(id)Model Classtype:(FSO)type;
-(BOOL)syncDeleteToDB:(id)Model Classtype:(FSO)type;

//删除表的数据
-(void)clearTableData:(FSO)type;

//根据条件删除数据
-(void)deleteWhereData:(NSDictionary *)Model Classtype:(FSO)type;

//查找数据
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result;
-(NSArray*)syncSearchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type;

//直接执行SQL语句
-(void)rawSql:(NSString*) sql Classtype:(FSO)type callback:(void(^)(NSArray *))result;
-(NSArray*)syncRawSql:(NSString*)sql Classtype:(FSO)type;
//获取某一张表的所有数据  -- 存在不可预知的数据库问题，此方法弃用
//- (NSArray *)rawSQL_AllDataByClasstype:(FSO)type;
//获取一张表的所有数据 方法1： where 1=1
- (NSArray *)searchAllDataOrderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type;

@end
