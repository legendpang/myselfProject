//
//  AppDelegate.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "Header.h"
#import "Function.h"
#import <BaiduMapAPI/BMapKit.h>
#import "AFNetworking.h"
#import "APService.h"
#import "WelcomeViewController.h"
@interface AppDelegate () <BMKGeneralDelegate>

@end

@implementation AppDelegate
{
    BMKMapManager * _bMapManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    RootTabBarViewController * tab = [[RootTabBarViewController alloc]init];
    
    if ([[Function getValueForKey:FIRST_START] isEqualToString:@"FirstLaunch"]) {
        NSLog(@"非第一次启动");
        self.window.rootViewController = tab;
    }else {
        [Function saveValue:@"FirstLaunch" forKey:FIRST_START];
        NSLog(@"第一次启动");
        WelcomeViewController * welcomePage = [[WelcomeViewController alloc] init];
        self.window.rootViewController = welcomePage;
               //此方法是几秒之后执行block中的代码
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   
       });

    }
    
    
    AFHTTPRequestOperationManager * net = [AFHTTPRequestOperationManager manager];
    [net.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            ////
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            ///
        }else{
            // NSLog(@"AppDelegate请设置网络");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络链接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            //展示UIAlertView@
            [alertView show];
        }
    }];
    [net.reachabilityManager startMonitoring];
    
    _bMapManager = [[BMKMapManager alloc] init];
    
    NSLog(@"%d",[_bMapManager start:@"6q4VRGtQ9OggGnoQQsW7rshM" generalDelegate:self])
    
    ;
    

    return YES;
}
//鉴权回调
- (void)onGetPermissionState:(int)iError
{
    NSLog(@"AppDelegate.m鉴权--->%d", iError);
}
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    [APService registerDeviceToken:deviceToken];
//    
//    [APService setDebugMode];
//
//}
//
//
//
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    [APService handleRemoteNotification:userInfo];
//}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    [APService handleRemoteNotification:userInfo];
//    //系统Block回调
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    [APService showLocalNotificationAtFront:notification identifierKey:nil];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
