//
//  Function.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "Function.h"

@implementation Function
+(id)getValueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
+(void)saveValue:(id)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}
+(UIBarButtonItem *)barButtonTitle:(NSString *)title Image:(NSString *)image Target:(id)target Sel:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButton;
    
}
@end
