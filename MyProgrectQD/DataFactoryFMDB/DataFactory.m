//
//  DataFactory.m
//
//
//  Created by 刘晓飞 on 13-5-20.
//  Copyright (c) 2013年 Sky. All rights reserved.
//

#import "DataFactory.h"
#import "LKDaoBase.h"
//#import "utils.h"

@implementation DataFactory
@synthesize classValues;
+(DataFactory *)shardDataFactory
{
    static id ShardInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ShardInstance=[[self alloc]init];
    });
    return ShardInstance;
}
-(NSString*)getDBPath {
    NSString* dbpath = GetDataBasePath;
    //NSString* realDBPath = [utils getRealDBPath:dbpath updateScriptSQL:@"db_update_UMCall.sql"];
    NSString* realDBPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/MyApp7.db"];
    NSLog(@"--数据库路径--*%@",realDBPath);
    return realDBPath;
}
-(BOOL)IsDataBase
{
    BOOL Value=NO;
    if (![SandboxFile IsFileExists:[self getDBPath]])
    {
        Value=YES;
    }
    return Value;
}
-(void)CreateDataBase
{
    self.queue=[[[FMDatabaseQueue alloc]initWithPath:[self getDBPath]]autorelease];
}
-(void)CreateTable
{
    [[[CompanyModelBase                 alloc]initWithDBQueue:self.queue]autorelease];
    [[[PlacetestModelBase                 alloc]initWithDBQueue:self.queue]autorelease];
    
}
-(id)Factory:(FSO)type
{
    id result = nil;
    self.queue=[[[FMDatabaseQueue alloc]initWithPath:[self getDBPath]]autorelease];
    switch (type)
    {
        
        case company:
            result=[[[CompanyModelBase               alloc]initWithDBQueue:self.queue]autorelease];
            break;
        case placeTest:
            result =[[[PlacetestModelBase                 alloc]initWithDBQueue:self.queue]autorelease];
            break;
        default:
            break;
    }
    return result;
}
-(void)insertToDB:(id)Model Classtype:(FSO)type
{
        __block id _classValues=[self Factory:type];
        [_classValues insertToDB:Model callback:^(BOOL Values)
         {
//             D("添加%d",Values);
             //[_classValues close];
         }];
}
-(BOOL)syncInsertToDB:(id)Model Classtype:(FSO)type
{
    @synchronized(self) {
        id _classValues=[self Factory:type];
        BOOL ret = [_classValues syncInsertToDB:Model];
        [_classValues syncClose];
        return ret;
    }
}
-(void)updateToDB:(id)Model Classtype:(FSO)type
{
        __block id _classValues=[self Factory:type];
        [_classValues updateToDB:Model callback:^(BOOL Values)
         {
//             D("修改%d",Values);
             //[_classValues close];
         }];
}
-(BOOL)syncUpdateToDB:(id)Model Classtype:(FSO)type
{
    @synchronized(self) {
        id _classValues=[self Factory:type];
        BOOL ret = [_classValues syncUpdateToDB:Model];
        [_classValues syncClose];
        return ret;
    }
}
-(void)syncBatchUpdateToDB:(NSArray *)dataArray Classtype:(FSO)type{
    @synchronized(self) {
        id _classValues=[self Factory:type];
        [_classValues updateBatchDataToDB:dataArray];
        [_classValues syncClose];
    }
}

-(void)deleteToDB:(id)Model Classtype:(FSO)type
{
        __block id _classValues=[self Factory:type];
        [_classValues deleteToDB:Model callback:^(BOOL Values)
         {
//             D("删除%d",Values);
             //[_classValues close];
         }];
}
-(BOOL)syncDeleteToDB:(id)Model Classtype:(FSO)type
{       id _classValues=[self Factory:type];
        BOOL ret = [_classValues syncDeleteToDB:Model];
        [_classValues syncClose];
        return ret;
}
-(void)clearTableData:(FSO)type
{
        id _classValues=[self Factory:type];
        [_classValues clearTableData];
}
-(void)deleteWhereData:(NSDictionary *)Model Classtype:(FSO)type
{
        __block id _classValues=[self Factory:type];
        [_classValues deleteToDBWithWhereDic:Model callback:^(BOOL Values)
         {
            
             //[_classValues close];
         }];
}
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result
{
        __block id _classValues=[self Factory:type];
        [_classValues searchWhereDic:where orderBy:columeName offset:offset count:count callback:^(NSArray *array)
         {
             //[_classValues close];
             result(array);
         }];
}
-(NSArray*)syncSearchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type
{
    @synchronized(self) {
        id _classValues=[self Factory:type];
        NSArray* ret = [_classValues syncSearchWhereDic:where orderBy:columeName offset:offset count:count];
        [_classValues syncClose];
        return ret;
    }
}
-(void)rawSql:(NSString*) sql Classtype:(FSO)type callback:(void(^)(NSArray *))result
{
        __block id _classValues=[self Factory:type];
        [_classValues rawSql:sql callback:^(NSArray *array)
         {
             //[_classValues close];
             result(array);
         }];
}

-(NSArray*)syncRawSql:(NSString*) sql Classtype:(FSO)type
{
    @synchronized(self) {
        id _classValues=[self Factory:type];
        NSArray* ret = [_classValues syncRawSql:sql withArgumentsInArray:nil];
        [_classValues syncClose];
        return ret;
    }
}
#pragma mark  获取某一张表的所有数据 -- 弃用
/**
 @author Jesus        , 16-03-30 16:03:36
 
 @brief 获取某一张表的所有数据
 

 
 @param type
 
 @return
 */
//- (NSArray *)rawSQL_AllDataByClasstype:(FSO)type {
//    /*
//      暂时只实现了topContacts表，其他表谁用谁加
//     
//     */
//    NSString * tableName = @"";
//    switch (type) {
//        case topContacts:
//            tableName = @"topContacts";
//            break;
//        case signIn:
//            tableName = @"signIn";
//            break;
//        default:
//            break;
//    }
//    
//    __block  NSMutableArray * result = [[NSMutableArray alloc]init];
//    [self rawSql:[NSString stringWithFormat:@"select * from %@",tableName] Classtype:type callback:^(NSArray * resultArray){
//        result = [NSMutableArray arrayWithArray:resultArray];
//    }];
//    return result;
//}

#pragma mark   获取一张表的所有数据 方法1： where 1=1
/**
 @author Jesus        , 16-07-12 14:07:08
 
 @brief 获取一张表的所有数据 方法1： where 1=1
 
 @param columeName
 @param offset
 @param count
 @param type
 
 @return 
 */
- (NSArray *)searchAllDataOrderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type {
    __block  NSMutableArray * result = [[NSMutableArray alloc]init];
    NSMutableDictionary * search = [NSMutableDictionary dictionary];
    [search setValue:@(1) forKey:@"1"];
    [[DataFactory shardDataFactory]searchWhere:search orderBy:columeName offset:offset count:count Classtype:type callback:^(NSArray *resultArray) {
        result = [NSMutableArray arrayWithArray:resultArray];
    }];
    return result;
}
-(void)dealloc
{
    self.classValues = nil;
    [super dealloc];
}
@end
