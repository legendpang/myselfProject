//
//  YC_FMDBManager.m
//  Day06-FMDB-封装
//
//  Created by 潘颖超 on 15/9/26.
//  Copyright © 2015年 Meakelra. All rights reserved.
//

#import "YC_FMDBManager.h"

@implementation YC_FMDBManager
//<1>
+ (YC_FMDBManager *)shareManager{
    static YC_FMDBManager *manager = nil;
    if (manager == nil) {
        manager = [[YC_FMDBManager alloc] init];
    }
    return manager;
}
- (instancetype)init
{
   
    self = [super init];
    if (self) {
        //<1>创建数据库在手机沙盒路径下的确定路径
        //数据库是以.db 或 .splite 结尾的类型
        //数据库是存放到沙盒的Documents里面的
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/MyApp7.db"];
        NSLog(@"%@",path);
        //<2>创建数据库
        //数据库的创建：如果沙盒路径下面已经存在相同名字的数据库，那么直接打开，如果不存在，那么创建
        _fmdb = [[FMDatabase alloc] initWithPath:path];
        //<3>打开数据库
        BOOL open = [_fmdb open];
        if (open) {
            //打开成功
            //<4>创建表格
            //表格与数据库一样，没有相同文件名字时，创建；存在相同名字时打开
            //<a>创建sqlite语句
            NSString *sql = @"create table if not exists MyApp (ID integer primary key,name varchar(256),characteristic varchar(256),image varchar(256),cid varchar(256),tag varchar(256),iId varchar(256))";
            /*
             ID:主键，不能重复
             name、age：字符串类型  varchar(256)256字节
             blob：二进制格式，data的格式
             //图片只能转为data类型存放
             */
            //<2>创建表格
            BOOL success = [_fmdb executeUpdate:sql];
            //executeUpdate:除查询不用这个语句，其他的全是这个语句（增、删、创、改）
            if (success) {
                NSLog(@"创建成功");
            }else{
                NSLog(@"%@",_fmdb.lastErrorMessage);
            }
            
        }else{
            NSLog(@"%@",_fmdb.lastErrorMessage);
        }

    }
    return self;
}
//<2>
- (void)insertInfo:(PlaceModel *)model andID:(NSInteger)ID {
    //<1>创建sql语句
    NSString *sql = @"insert into MyApp(ID,name,characteristic,cid,image,tag,iId) values(?,?,?,?,?,?,?)";
    //?占位符，需要写入的元素   ［注意］不能存放基本类型
    //<2>插入元素
    NSString *name = model.name;
    NSString *characteristic  = model.characteristic;
    NSString *cid = model.cid;
   NSString * image = model.image;
    //将NSInteger转为NSNumber
    NSNumber *number = [NSNumber numberWithInteger:ID];
    NSString * tag = model.tag;
    NSString * iId = model.iId;
    BOOL success = [_fmdb executeUpdate:sql,number,name,characteristic,cid,image,tag,iId];
    if (success) {
        NSLog(@"成功插入元素");
    }else{
        NSLog(@"%@",_fmdb.lastErrorMessage);
    }
}
//<3>
//- (void)updataInfo:(PlaceModel *)model andID:(NSInteger)ID{
//    //<1>
//    NSString *sql = @"update MyApp set name = ?,characteristic = ? image = ?where ID = ?";
//    //<2>
//    BOOL success = [_fmdb executeUpdate:sql,model.name,model.characteristic,[NSNumber numberWithInteger:ID]];
//    if (success) {
//        NSLog(@"修改成功");
//    }else{
//        NSLog(@"%@",_fmdb.lastErrorMessage);
//    }
//}
//<4>
- (NSArray *)allPersonInfos{
    //查询
    //<1>创建语句
    NSString *sql = @"select * from MyApp";
    //<2>查询语句
    FMResultSet *set = [_fmdb executeQuery:sql];
    //<3>判断是否查询成功
    //创建数组，将数据放到数组里面
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    while ([set next]) {
       PlaceModel *model = [[PlaceModel alloc] init];
        model.name = [set stringForColumn:@"name"];
        model.characteristic = [set stringForColumn:@"characteristic"];
       model.image = [set stringForColumn:@"image"];
        model.cid = [set stringForColumn:@"cid"];
        model.tag = [set stringForColumn:@"tag"];
        model.iId = [set stringForColumn:@"iId"];
        [array addObject:model];
    }
    return array;
}
-(void)deletePersonInfo:(NSString *)name
{
    NSString *sql = @"delete from MyApp where name = ?";
    //<2>删除元素
//     PlaceModel *model = [[PlaceModel alloc] init];//注意参数?????
    BOOL success = [_fmdb executeUpdate:sql,name];
    if (success) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"%@",_fmdb.lastErrorMessage);
    }
}

@end
