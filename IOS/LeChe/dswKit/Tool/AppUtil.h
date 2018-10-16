//
//  WLAppStoreUtil.h
//  Util
//
//  Created by stephen on 13-11-4.
//  Copyright (c) 2014年 dsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ firstLuanchBlock)(void);

// ****************************************device****************************************
#pragma mark - device

#define IOS_VERSION_7_OR_ABOVE  (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? (YES) : (NO))

#define IOS_VERSION_8_OR_ABOVE  (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? (YES) : (NO))

#define  IOS_VERSION_9_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? (YES) : (NO))

#define IOS_VERSION_7           (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)) ? (YES) : (NO))

#define IOS_VERSION_6           (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)) ? (YES) : (NO))

// **************************************屏幕******************************************
#pragma mark -  屏幕
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...)
#endif

#define APP_FRAEM   ([UIScreen mainScreen].bounds)
#define APP_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define APP_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
//状态栏高度
#define APP_STATUSBARHEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//标签栏高度
#define APP_TABBARHEIGHT APPDELEGATE.tabController.tabBar.frame.size.height
//导航栏高度
#define APP_NAVIGATIONBARHEIGHT NAVIGATION.navigationBar.frame.size.height

#define APP_NAVHEIGHT (APP_STATUSBARHEIGHT==20?64:88)

// **************************************屏幕******************************************
#define IPHONE4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)


#define IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS9   [UIDevice currentDevice].systemVersion.floatValue >= 9.0

@interface AppUtil : NSObject

#pragma mark device

/**
 *  获取openUDID
 *
 */
+ (NSString *)getOpenUDID;

/**
 *  获取设备名
 *
 */
+ (NSString *)getDeviceName;

/**
 *  是否联网
 *
 */
+ (BOOL)isConnectedToNetwork;

/**
 *  网络类型
 *
 */
+ (NSString *)getNetWorkStates;

/**
 *  分辨率
 *
 */
+ (NSString *)getResolution;

#pragma mark app

/**
 *  获取app版本
 *
 */
+ (NSString *)getAPPVersion;

/**
 *  获取app内部版本
 *
 */
+ (NSString *)getAPPBuild;

/**
 *  APP Store 上打开应用
 *
 */
+ (BOOL)appStoreWithAppId:(NSString *)appId;

/**
 *  safari 打开链接
 *
 */
+ (void)safari:(NSString *)urlString;

/**
 *  拨打电话
 *
 */
+ (BOOL)dial:(NSString *)tel;

/**
 *  打开APP
 *
 */
+ (BOOL)openApp:(NSString *)url;

/**
 *  获取IDFA
 *
 */
+  (NSString*)getAPPIDFA;


/**
 *  跳转评论
 *
 *
 */
+ (void)openAPPComment:(NSString *)appid;

/**
 *  获取主窗口
 *
 */
+ (UIWindow *)getAppWindow;

#pragma mark other
+ (void)onceAction:(NSString *)key block:(firstLuanchBlock)block;

+ (void)onceAction:(NSString *)key block:(firstLuanchBlock)block otherBlock:(firstLuanchBlock)blockOther;

#pragma mark - 格式化数据

/**
 格式化数据：9亿6359万6299人(元)

 @param money 总数
 @param moneyFlag YES.元  NO.人
 */
+ (NSString *)splitNumber:(long) money moneyFlag:(BOOL)moneyFlag;


/**
 调控首页view展示风格
 
 */
+ (NSMutableAttributedString *)attributedStrWithNormalStr:(NSString *)normalStr fontStr:(NSString *)fontStr fontType:(UIFont *)fontType;


/**
 判断是否是同一天

 */
+ (BOOL)isTheSameDay;

/**
 判断是否在某时间区间内

 @param startStr 开始时刻
 @param endStr 结束时刻
 */
+ (BOOL)judgeTimeByStartAndEnd:(NSString *)startStr EndTime:(NSString *)endStr;


/**
 注册成功后弹框
 */
+ (void)popView;

@end
