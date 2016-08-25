//
//  CompanyModel.m
//  Data
//
//  Created by 刘晓飞 on 13-5-20.
//  Copyright (c) 2013年 Sky. All rights reserved.
//

#import "CompanyModel.h"
@implementation CompanyModelBase
+(Class)getBindingModelClass
{
    return [CompanyModel class];//返回商家实体
}
const static NSString* tablename = @"Company";//表名
+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation CompanyModel

@synthesize orgid,version,shortName,password,autoRemember,autoLogin,fullName,createrName,createrphoneNo,ex,defaultPassword,logoName, logoState;

-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"orgid";//主健
    }
    return self;
}
- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self)
    {
        self.orgid=[dic objectForKey:@"orgid"];
        self.version=[dic objectForKey:@"version"];
        self.shortName=[dic objectForKey:@"shortName"];
        self.autoLogin = [dic objectForKey:@"autoLogin"];
        self.autoRemember = [dic objectForKey:@"autoRemember"];
        self.password = [dic objectForKey:@"password"];
        
        self.fullName = [dic objectForKey:@"fullName"];
        self.createrName = [dic objectForKey:@"createrName"];
        self.createrphoneNo = [dic objectForKey:@"createrphoneNo"];
        self.ex = [dic objectForKey:@"ex"];
        self.defaultPassword = [dic objectForKey:@"defaultPassword"];
    }
    return self;
}
//===========================================================
// dealloc
//===========================================================
-(void)dealloc
{
    [orgid release];
    [version release];
    [shortName release];
    [autoRemember release];
    [autoLogin release];
    [password release];
    [fullName release];
    [createrphoneNo release];
    [createrName release];
    [ex release];
    [defaultPassword release];
    [logoName release];
    [super dealloc];
}
@end
