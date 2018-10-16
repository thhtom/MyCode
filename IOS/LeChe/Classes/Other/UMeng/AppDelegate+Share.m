//
//  AppDelegate+Share.m
//  LeChe
//
//  Created by yangxuran on 2018/4/26.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "AppDelegate+Share.h"
#import <UMShare/UMShare.h>

@implementation AppDelegate (Share)

- (void)umengShare {
    //[WXApi registerApp:KYE_WXAppId];// 此为申请下来的key一般以wx开头
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5adfe58ef29d985662000172"];
    
    [self configUSharePlatforms];
}

- (void)configUSharePlatforms {
    //WX
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxcd477ebe0fb7553b" appSecret:@"c86c6a1741169d976d170fb433e605c7" redirectURL:nil];
    
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106878748"/*设置QQ平台的appID*/  appSecret:@"gMTKgUszKEiZynSG" redirectURL:@"http://mobile.umeng.com/social"];
    
    //Sina
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3036939948"  appSecret:@"2ec2f90ef6d00d74cda5260534e63d5a" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
