//
//  AppDelegate+Message.h
//  LeChe
//
//  Created by yangxuran on 2018/4/26.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (Message)<UNUserNotificationCenterDelegate>

- (void)umengMessage:(NSDictionary *)launchOptions;

@end
