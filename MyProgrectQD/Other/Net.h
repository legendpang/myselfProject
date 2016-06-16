//
//  Net.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ SuccessBlock) (id object);

typedef void (^ FailureBlock) (NSError * error);


@interface Net : NSObject

+(void)getHttpURL:(NSString *)url completation:(SuccessBlock)success failure:(FailureBlock)failure andType:(NSString *)type;

//Post方式网络请求


@end
