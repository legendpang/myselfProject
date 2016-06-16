//
//  StarView.h
//  LoveLimitApp
//
//  Created by 潘颖超 on 15/10/8.
//  Copyright © 2015年 Meakelra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

//<29>声明两个属性：UIImageView类型；一个是灰色的星星，一个是橘色的星星
//StarsBackground.png  hui
//StarsForeground.png   ju
@property (nonatomic, strong) UIImageView *backgroundImage;//灰色的
@property (nonatomic, strong) UIImageView *foregroundImage;//橘色的

//<30>设置相关的星级，并切割多余的图片
- (void)setStarLevel:(NSString *)level;

@end
