//
//  RootViewController.h
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "Function.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "Net.h"
#import "PlaceModel.h"
@interface RootViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * urlStr;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSMutableArray * dataArray;
-(instancetype)initWithTitle:(NSString *)title tabTitle:(NSString *)tabTitle tabImage:(NSString *)image andSelectImage:(NSString *)selectImage;
- (void)createBarButtonLeftTitle:(NSString *)leftTitle LeftImage:(NSString *)leftImage RightTitle:(NSString *)rightTitle RightImage:(NSString *)rightImage;
- (void)leftBarButtonClick:(UIBarButtonItem *)left;
- (void)rightBarButtonClick:(UIBarButtonItem *)right;
-(void)statrRequest:(NSString *)url AndTag:(NSInteger)tag;

@end
