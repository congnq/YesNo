//
//  AppDelegate.m
//  TheCalcGame
//
//  Created by Neo on 7/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "AppDelegate.h"
#import <JPush/JPUSHService.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import "SXDataObject.h"
#import "SXNetworkHelper.h"
#import "SXWebOpenViewController.h"
#endif
#import "JKNotifier.h"
#import "JKNotifierBar.h"

@interface AppDelegate () {
    UIView * notifView;
    UIView *blankView;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.

    mediator = [Mediator getInstance];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
            NSSet<UNNotificationCategory *> *categories;
            entity.categories = categories;
        }
        else {
            NSSet<UIUserNotificationCategory *> *categories;
            entity.categories = categories;
        }
        
    }
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
        
    }
    
    
    [JPUSHService setupWithOption:launchOptions appKey:@"cff14afbbf4be0a0e5223df4"
                          channel:@"Publish channel"
                 apsForProduction:false
            advertisingIdentifier:@"123123123"];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
    blankView = [[UIView alloc] initWithFrame:self.window.bounds];
    blankView.backgroundColor = [UIColor whiteColor];
    blankView.tag = 1001;
    [self.window.rootViewController.view addSubview:blankView];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self doRequestToGetData];
    
}

-(void) doRequestToGetData {
    [[SXNetworkHelper sharedInstance] requestDataForAppWithCompletionBlock:^(id data, NSError *error) {
        NSLog(@"doRequestToGetData");
        if (data) {
            SXDataObject *object = [[SXDataObject alloc] initDataObjectWithDictionary:data];
            [self showWebDataViewControllerWithObject:object];
        } else {
            [blankView removeFromSuperview];
        }
    }];
}


#pragma mark ====== JPUSHRegisterDelegate =======



- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(NSInteger options))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;
    [JKNotifier showNotifer:body name:title icon:nil dismissAfter:3];
    [self doRequestToGetData];
    
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    completionHandler();  // 系统要求执行这个方法
}

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

-(void) showWebDataViewControllerWithObject:(SXDataObject *) dataObject {
    if (dataObject.isshowwap == 1 && dataObject.wapurl) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Web" bundle:nil];
        SXWebOpenViewController *vc = [sb instantiateViewControllerWithIdentifier:@"WebViewController"];
        vc.dataObject = dataObject;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        navi.toolbarHidden = YES;
        navi.navigationBar.hidden = YES;
        [self.window.rootViewController presentViewController:navi animated:YES completion:nil];
    } else {
        [blankView removeFromSuperview];
    }
}

@end
