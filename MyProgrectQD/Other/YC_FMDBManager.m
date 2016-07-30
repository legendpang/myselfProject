//
//  YC_FMDBManager.m
//  Day06-FMDB-封装
//
//  Created by 潘颖超 on 15/9/26.
//  Copyright © 2015年 Meakelra. All rights reserved.
//

#import "YC_FMDBManager.h"
#import<objc/runtime.h>
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
        if (_columnNameArr==nil) {
            _columnNameArr = [[NSMutableArray alloc] init];
        }
        if (_columnTypeArr == nil) {
            _columnTypeArr = [[NSMutableArray alloc] init];
        }
        
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
            //NSString *sql = @"create table if not exists MyApp (ID integer primary key,name varchar(256),characteristic varchar(256),image varchar(256),cid varchar(256),tag varchar(256),iId varchar(256))";
            /*
             ID:主键，不能重复
             name、age：字符串类型  varchar(256)256字节
             blob：二进制格式，data的格式
             //图片只能转为data类型存放
             */
            
            
            //<2>创建表格
//            BOOL success = [_fmdb executeUpdate:sql];
//            //executeUpdate:除查询不用这个语句，其他的全是这个语句（增、删、创、改）
//            if (success) {
//                NSLog(@"创建成功");
//            }else{
//                NSLog(@"%@",_fmdb.lastErrorMessage);
//            }
            [self creatTable];
        }else{
            NSLog(@"%@",_fmdb.lastErrorMessage);
        }

    }
    return self;
}
//一个数据库创建多张表
-(void)creatTable
{
    NSArray * tableNameArr = @[@"placeModel",@"foodModel"];
    for (int i=0; i<tableNameArr.count; i++) {
        NSString * sql = [self setTableSql:i andTableName:tableNameArr];
        BOOL success = [_fmdb executeUpdate:sql];
        if (success) {
            NSLog(@"-%@表创建成功",tableNameArr[i]);
        }else{
            NSLog(@"%@",_fmdb.lastErrorMessage);
        }
    }
}

- (NSString *)setTableSql:(FSO)type andTableName:(NSArray *)tableNameArr
{
   
    NSString * sql = @"";
    switch (type) {
        case placeModel:{
        sql = [NSString stringWithFormat:@"create table if not exists %@ (ID integer primary key,%@)",[tableNameArr objectAtIndex:type],[self setSql:[[tableNameArr objectAtIndex:type] uppercaseString]]];
        }
            break;
        case foodModel:{
            sql = [NSString stringWithFormat:@"create table if not exists %@ (ID integer primary key,%@)",[tableNameArr objectAtIndex:type],[self setSql:[[tableNameArr objectAtIndex:type] uppercaseString]]];
            ;
        }
        default:
            break;
    }
    return sql;
}

//创建sql语句
-(NSString *)setSql:(NSString *)classTableName
{
    
    [self getAllProperties:classTableName];
    NSString * sql = [self getParameterString];
    return sql;
}

//获取某张表的所有属性及类型
- (void)getAllProperties:(NSString *)className
{
    
    [_columnTypeArr removeAllObjects];
    [_columnNameArr removeAllObjects];

    u_int count;
    //用这个类要导入#import<objc/runtime.h>，否则会报错
    objc_property_t *properties  =class_copyPropertyList([NSClassFromString(className) class], &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *propertiestypeArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
        
    {
        
        const char* propertyName =property_getName(properties[i]);
        const char* propertyType =property_getAttributes(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
        [propertiestypeArray addObject:[NSString stringWithUTF8String:propertyType]];
        
    }
   
    for (NSString * str in propertiestypeArray) {
         NSString * propertType = @"";
        if ([str characterAtIndex:1]=='@') {
            if (str.length >= 12) {
                if ([[str substringToIndex:12] isEqualToString:@"T@\"NSString\""]) {
                    propertType = @"NSString";
                    
                }
            }else{
                propertType = @"";
            }
        }else if ([str characterAtIndex:1]=='d'){
            propertType = @"double";
        }else if ([str characterAtIndex:1]=='q'){
             propertType = @"NSInteger";
        }else if ([str characterAtIndex:1]=='i'){
             propertType = @"int";
        }
    }
    [_columnNameArr addObjectsFromArray:propertiesArray];
    for (NSString * typeStr in propertiestypeArray) {
        [_columnTypeArr addObject:[self toDBType: typeStr]];
    }
    
    
    free(properties);
}

const static NSString* normaltypestring = @"floatdoublelongcharshort";
const static NSString* blobtypestring = @"NSDataUIImage";
-(NSString *)toDBType:(NSString *)type
{
    if([type isEqualToString:@"int"])
    {
        return LKSQLInt;
    }
    if ([normaltypestring rangeOfString:type].location != NSNotFound) {
        return LKSQLDouble;
    }
    if ([blobtypestring rangeOfString:type].location != NSNotFound) {
        return LKSQLBlob;
    }
    return LKSQLText;
}
-(NSString *)getParameterString
{
    NSMutableString* pars = [NSMutableString string];
    for (int i=0; i<_columnNameArr.count; i++) {
        [pars appendFormat:@"%@ %@",[_columnNameArr objectAtIndex:i],[_columnTypeArr objectAtIndex:i]];
        if(i+1 !=_columnNameArr.count)
        {
            [pars appendString:@","];
        }
    }
    return pars;
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
