//
//  FourViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FourViewController.h"
#import "CollectionViewController.h"
#import "FourthCell.h"
#import "AboutusViewController.h"
#import "UMSocial.h"
#import "ConnectionUsViewController.h"
#import "MyNavigationBar.h"
@interface FourViewController ()<UMSocialUIDelegate>

@property(nonatomic ,strong)NSMutableArray * sdataArray;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blueColor];
    MyNavigationBar * mynav = [[MyNavigationBar alloc] initWithTitle:@"设置" withColor:[UIColor whiteColor]];
    [self.view addSubview:mynav];
    
    
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray * array = @[@"我的收藏",@"小贴士",@"我要分享",@"联系我们"];
    self.tableView.footer = nil;
    self.tableView.header = nil;
    _sdataArray = [NSMutableArray arrayWithArray:array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FourthCell" bundle:nil] forCellReuseIdentifier:@"fourth"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sdataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FourthCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"fourth" forIndexPath:indexPath];
    
    cell.title1Label.text = _sdataArray[indexPath.row];
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CollectionViewController * collection = [[CollectionViewController alloc]init];
    AboutusViewController * aboutus = [[AboutusViewController alloc]init];
    if (indexPath.row == 0) {
         [self.navigationController pushViewController:collection animated:YES];
        collection.headTitle = _sdataArray[indexPath.row];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:aboutus animated:YES];
        aboutus.headTitle = _sdataArray[indexPath.row];
    }else if (indexPath.row == 2){
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"5507875dfd98c5fef20001dd"
                                          shareText:@"不错的App!!!"
                                         shareImage:nil
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter,nil]
                                           delegate:self];

    }else if (indexPath.row == 3){
        ConnectionUsViewController * connection = [[ConnectionUsViewController alloc]init];
        connection.headTitle = _sdataArray[indexPath.row];
        [self.navigationController pushViewController:connection animated:YES];
    }
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
