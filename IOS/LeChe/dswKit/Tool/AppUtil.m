//
//  WLAppStoreUtil.m
//  Util
//
//  Created by dsw on 13-11-4.
//  Copyright (c) 2014年 dsw All rights reserved.
//

#import "AppUtil.h"
#import "OpenUDID.h"

#import <sys/utsname.h>

#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#import <AdSupport/AdSupport.h>

#import "NSString+quick.h"
#import "HRRedInterestView.h"

@implementation AppUtil

#pragma mark - device

+ (BOOL)isConnectedToNetwork {
    // Create zero address
    struct sockaddr_in zeroAddress;

    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    // Recover reachability flags
    SCNetworkReachabilityRef    defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags  flags;
    BOOL                        didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if (!didRetrieveFlags) {
        // printf("Error. Could not recover network reachability flags\n");
        return 0;
    }

    BOOL    isReachable = flags & kSCNetworkFlagsReachable;
    BOOL    needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 *  分辨率
 *
 */
+ (NSString *)getResolution {
    CGFloat scale_screen = [UIScreen mainScreen].scale;

    return [NSString stringWithFormat:@"%.0f*%.0f", APP_WIDTH * scale_screen, APP_HEIGHT * scale_screen];
}

+ (NSString *)getNetWorkStates {
    UIApplication   *app = [UIApplication sharedApplication];
    NSArray         *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString        *state = [[NSString alloc]init];
    int             netType = 0;

    // 获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            // 获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];

            switch (netType) {
                case 0:
                    state = @"无网络";
                    // 无网模式
                    break;

                case 1:
                    state = @"2G";
                    break;

                case 2:
                    state = @"3G";
                    break;

                case 3:
                    state = @"4G";
                    break;

                case 5:
                    {
                        state = @"WIFI";
                    }
                    break;

                default:
                    break;
            }
        }
    }

    // 根据状态选择
    return state;
}

/**
 *  获取openUDID
 *
 */
+ (NSString *)getOpenUDID {
    return [OpenUDID value];
}

+ (NSString *)getDeviceName {
    struct utsname systemInfo;

    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

#pragma mark iphone

    if ([deviceString isEqualToString:@"iPhone1,1"]) {
        return @"iPhone 1G";
    }

    if ([deviceString isEqualToString:@"iPhone1,2"]) {
        return @"iPhone 3G";
    }

    if ([deviceString isEqualToString:@"iPhone2,1"]) {
        return @"iPhone 3GS";
    }

    if ([deviceString isEqualToString:@"iPhone3,1"]) {
        return @"iPhone 4";
    }

    if ([deviceString isEqualToString:@"iPhone3,2"]) {
        return @"Verizon iPhone 4";
    }

    if ([deviceString isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4S";
    }

    if ([deviceString isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    }

    if ([deviceString isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5S";
    }

    if ([deviceString isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }

    if ([deviceString isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6plus";
    }

    if ([deviceString isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    }

    if ([deviceString isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6splus";
    }

#pragma mark ipad

    if ([deviceString isEqualToString:@"iPad1,1"]) {
        return @"iPad";
    }

    if ([deviceString isEqualToString:@"iPad2,1"]) {
        return @"iPad 2 (WiFi)";
    }

    if ([deviceString isEqualToString:@"iPad2,2"]) {
        return @"iPad 2 (GSM)";
    }

    if ([deviceString isEqualToString:@"iPad2,3"]) {
        return @"iPad 2 (CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad3,1"]) {
        return @"iPad 3 (WiFi)";
    }

    if ([deviceString isEqualToString:@"iPad3,2"]) {
        return @"iPad 3 (CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad3,3"]) {
        return @"iPad 3 (GSM)";
    }

    if ([deviceString isEqualToString:@"iPad3,4"]) {
        return @"iPad 4 (WiFi)";
    }

    if ([deviceString isEqualToString:@"iPad3,5"]) {
        return @"iPad 4 (GSM)";
    }

    if ([deviceString isEqualToString:@"iPad3,6"]) {
        return @"iPad 4 (GSM+CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad4,1"]) {
        return @"iPad Air (wifi)";
    }

    if ([deviceString isEqualToString:@"iPad4,2"]) {
        return @"iPad AIR (GSM+CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad4,3"]) {
        return @"iPad ARI (GSM+TD)";
    }

    if ([deviceString isEqualToString:@"iPad4,4"]) {
        return @"iPad mini2 (WIFI)";
    }

    if ([deviceString isEqualToString:@"iPad4,5"]) {
        return @"iPad mini2 (GSM+CDMA)";
    }

    if ([deviceString isEqualToString:@"iPad4,6"]) {
        return @"iPad mini2 (GSM+TD)";
    }

    if ([deviceString isEqualToString:@"iPad4,7"]) {
        return @"iPad mini3 ";
    }

    if ([deviceString isEqualToString:@"iPad4,8"]) {
        return @"iPad mini3 ";
    }

    if ([deviceString isEqualToString:@"iPad4,9"]) {
        return @"iPad mini3 ";
    }

    if ([deviceString isEqualToString:@"iPad5,1"]) {
        return @"iPad mini4 ";
    }

    if ([deviceString isEqualToString:@"iPad5,2"]) {
        return @"iPad mini4 ";
    }

    if ([deviceString isEqualToString:@"iPad5,3"]) {
        return @"iPad air2 ";
    }

    if ([deviceString isEqualToString:@"iPad5,4"]) {
        return @"iPad air2 ";
    }

    if ([deviceString isEqualToString:@"i386"]) {
        return @"Simulator";
    }

    if ([deviceString isEqualToString:@"x86_64"]) {
        return @"Simulator";
    }

#pragma mark ipod

    if ([deviceString isEqualToString:@"iPod1,1"]) {
        return @"iPod Touch 1G";
    }

    if ([deviceString isEqualToString:@"iPod2,1"]) {
        return @"iPod Touch 2G";
    }

    if ([deviceString isEqualToString:@"iPod3,1"]) {
        return @"iPod Touch 3G";
    }

    if ([deviceString isEqualToString:@"iPod4,1"]) {
        return @"iPod Touch 4G";
    }

    if ([deviceString isEqualToString:@"iPod5,1"]) {
        return @"iPod Touch 5G";
    }

    if ([deviceString isEqualToString:@"iPod7,1"]) {
        return @"iPod Touch 6G";
    }

    return deviceString;
}

#pragma mark  - app

+ (UIWindow *)getAppWindow {
    return [UIApplication sharedApplication].delegate.window;;
}

+ (void)openAPPComment:(NSString *)appid {
    NSString *str = [NSString stringWithFormat:
        @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",
        appid];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+ (BOOL)appStoreWithAppId:(NSString *)appId {
    NSString *urlPath = [@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id="
        stringByAppendingString:appId];

    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPath]];
}

+ (void)safari:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    [[UIApplication sharedApplication] openURL:url];
}

+ (BOOL)dial:(NSString *)tel {
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"telprompt:%@", tel]];

    return [[UIApplication sharedApplication] openURL:url];
}

+ (BOOL)openApp:(NSString *)url {
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (NSString *)getAPPVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];

    return infoDic[@"CFBundleShortVersionString"];
}

+ (NSString *)getAPPBuild {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];

    return infoDic[@"CFBundleVersion"];
}

+  (NSString*)getAPPIDFA{
   
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
}

#pragma mark  - app
+ (void)onceAction:(NSString *)key block:(firstLuanchBlock)block {
    [AppUtil onceAction:key block:block otherBlock:^{}];
}

+ (void)onceAction:(NSString *)key block:(firstLuanchBlock)block otherBlock:(firstLuanchBlock)blockOther {
    NSString *VersionKey = [NSString stringWithFormat:@"v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]];

    NSString *key_ =@[NSStringFromClass([self class]), @"_", key, @"_DSWKey", VersionKey].joinedString;

    if (![[NSUserDefaults standardUserDefaults] boolForKey:key_]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key_];
        block();
    } else {
        blockOther();
    }
}

#pragma mark - 格式化数据
/**
 格式化数据：9亿6359万6299人(元)
 
 @param money 总数
 @param moneyFlag YES.元  NO.人
 */
+ (NSString *)splitNumber:(long) money moneyFlag:(BOOL)moneyFlag {
    long b = (long) (money/10e7);
    long m = (long) (money%100000000/10000);//10e7,10e3
    long t = (long) (money%10000);//10e3
    NSString *result = @"";
    
    if(b != 0) {
        result = [NSString stringWithFormat:@"%@%zd亿",result,b];//+=b+"亿";
    }
    if(m != 0) {
        result = [NSString stringWithFormat:@"%@%zd万",result,m];//+=m+"万";
    }
    if(t != 0) {
        if (moneyFlag == YES) {
            result = [NSString stringWithFormat:@"%@%zd元",result,t];
        } else {
            result = [NSString stringWithFormat:@"%@%zd人",result,t];
        }
        //+=t;
    }
    
    return result;
}

/**
 调控首页view展示风格
 
 */
+ (NSMutableAttributedString *)attributedStrWithNormalStr:(NSString *)normalStr fontStr:(NSString *)fontStr fontType:(UIFont *)fontType  {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:normalStr];
    [attributedStr setFont:fontType string:fontStr];
    [attributedStr setColor:RGBA(255, 77, 86, 1)];
    return attributedStr;
}

/**
 判断是否是同一天
 
 */
+ (BOOL)isTheSameDay {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    NSLog(@"之前时间：%@", [userDefault objectForKey:@"nowDate"]);//之前存储的时间
    //    NSLog(@"现在时间%@",[NSDate date]);//现在的时间
    NSDate *now = [NSDate date];
    
    NSDate *agoDate = [userDefault objectForKey:@"nowDate"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *agoDateString = [dateFormatter stringFromDate:agoDate];
    NSString *nowDateString = [dateFormatter stringFromDate:now];
    
//    NSLog(@"日期比较：之前：%@ 现在：%@",agoDateString,nowDateString);
    
    if ([agoDateString isEqualToString:nowDateString]) {
        return YES;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:now forKey:@"nowDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return NO;
}

/**
 判断是否在某时间区间内
 
 @param startStr 开始时刻
 @param endStr 结束时刻
 */
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startStr EndTime:(NSString *)endStr {
    //获取当前时间
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * todayStr=[dateFormat stringFromDate:today];//将日期转换成字符串
    //    today=[ dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    //    //start end 格式 "2016-05-18 9:00:00"
    //    NSDate *start = [dateFormat dateFromString:startStr];
    //    NSDate *expire = [dateFormat dateFromString:endStr];
    if ([todayStr compare:startStr] == NSOrderedDescending && [todayStr compare:endStr] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}


/**
 注册成功后的弹框
 */
+ (void)popView {
    HRRedInterestView *interestRatesView = [HRRedInterestView redInterestRatesView];
    interestRatesView.bounds = [AppUtil getAppWindow].bounds;
    interestRatesView.center = [AppUtil getAppWindow].center;
    [[AppUtil getAppWindow] addSubview:interestRatesView];
    
    __weak typeof(interestRatesView) weakView = interestRatesView;
    [interestRatesView setCloseClick:^{
        [weakView removeFromSuperview];
        NSLog(@"other operation...");
        [NAVIGATION toAccount];
    }];
}

@end
