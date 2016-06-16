//
//  ConnectionUsViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ConnectionUsViewController.h"

@interface ConnectionUsViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UILabel * placer;
@end

@implementation ConnectionUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick:)];
    _textLabel.text = @"本App由青岛旅游局和第三方公司联合开发,请对我们提出您的宝贵意见";
    
    _contextView.text = @"";
    _contextView.delegate = self;
    _placer = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 80, 15)];
    _placer.text = @"请输入文字";
    _placer.font = [UIFont systemFontOfSize:13.0];
   
    [_contextView addSubview:_placer];
    
}
-(void)rightClick:(UIBarButtonItem *)btn
{
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"发表成功" message:@"感谢对我们的支持" delegate:self cancelButtonTitle:@"返回" otherButtonTitles: nil];
    if(_contextView.text.length != 0){
        _contextView.text = @"";
        [alertView show];
    }
    [_contextView resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    _placer.hidden = YES;
    self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return YES;
    }
    
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_contextView resignFirstResponder];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
