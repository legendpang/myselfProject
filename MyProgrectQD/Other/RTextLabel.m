//
//  RTextLabel.m
//  MyProgrectQD
//
//  Created by Dalang on 2017/6/23.
//  Copyright © 2017年 qianfeng. All rights reserved.
//

#import "RTextLabel.h"
#import "RegexKitLite.h"
@implementation RTextLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
       self.text  = @"";
    }
    return self;
}
//判断NSString字符串是否包含UM表情
/*
 Ggggg ^zato^ggjjjhbhggg
 */
-(void)stringContainsUMEmoji:(NSString *)originalStr
{
    NSString *regex_emoji = @"\\^[a-z]{1,5}\\^";
    NSArray *array_emoji = [originalStr componentsMatchedByRegex:regex_emoji];
    if ([array_emoji count]) {
        for (NSString *str in array_emoji) {
            NSRange range = [originalStr rangeOfString:str];
            originalStr = [originalStr stringByReplacingCharactersInRange:NSMakeRange(range.location, [str length]) withString:@":"];
        }
   
    }
}

-(void)emoji{
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] init];
 
    NSTextAttachment *imageStr = [[NSTextAttachment alloc]init];
    
    imageStr.image = [UIImage imageNamed:@""];

    imageStr.bounds = CGRectMake(0, 0, 18, 18);
    
    NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:imageStr];
    
    [strM appendAttributedString:attrString];
    



}
@end
