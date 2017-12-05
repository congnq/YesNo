//
//  AppDelegate.h
//  TheCalcGame
//
//  Created by Neo on 7/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Mediator.h"
#import <JPush/JPUSHService.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate,UNUserNotificationCenterDelegate> {
    Mediator *mediator;
}

@property (strong, nonatomic) UIWindow *window;


@end

