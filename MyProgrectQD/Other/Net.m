//
//  Net.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Net.h"
#import "AFNetworking.h"
@implementation Net
+(void)getHttpURL:(NSString *)url completation:(SuccessBlock)success failure:(FailureBlock)failure andType:(NSString *)type
{
    if ([type isEqualToString:@"json"]) {
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/jpeg"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
        }];
    }else if ([type isEqualToString:@"text"]){
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
        }];
    }
    
    
}


@end
