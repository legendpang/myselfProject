//
//  Function.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Function : NSObject
+ (void)saveValue:(id)value forKey:(NSString *)key;
+ (id)getValueForKey:(NSString *)key;
+ (UIBarButtonItem *)barButtonTitle:(NSString *)title Image:(NSString *)image Target:(id)target Sel:(SEL)selector;
@end
