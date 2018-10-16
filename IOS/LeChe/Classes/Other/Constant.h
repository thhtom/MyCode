//
//  Constant.h
//
//  Created by yangxuran on 2018/2/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

//1. 日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define MyLog(...) printf("%s: %s 第%d行: %s\n\n",__TIME__, [MyString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
// 发布状态
#define MyLog(...)
#endif


#define SuppressPerformSelectorLeakWarning(Stuff)                           \
do {                                                                    \
_Pragma("clang diagnostic push")                                    \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff;                                                              \
_Pragma("clang diagnostic pop")                                     \
} while (0)


#define kPageSize 10

//图片宽高比
#define kAspectRatio 1.5

// 2.获得RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBColor(r, g, b) RGBA(r,g,b,1.0)


// 随机色
#define RandomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define kGlobalBg HexColor(0xF2F2F2)
#define kGloablRedColor RGBColor(217, 23, 0)
#define kGlobalDividerColor RGBColor(230, 230, 230)
#define kGlobalCellSelectedBg RGBAColor(237, 233, 218, 0.2)
#define kPlaceholderTextColor kFirstTextColor

#define kShadowColor RGBColor(79,152,252)
#define kGlobalTintColor RGBColor(255,228,1)

#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kFirstTextColor RGBA(51,51,51,1)
#define kSecondTextColor RGBColor(102,102,102)
#define kThirdTextColor HexColor(0x333333)

#define Img(name) [UIImage imageNamed:name]
#define Font(f) [UIFont systemFontOfSize:f]

// 定义高度
#define kUIScreenSize [UIScreen mainScreen].bounds.size
#define kUIScreenWidth kUIScreenSize.width

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabbarHeight (kStatusBarHeight > 20 ? 83:49)
#define kNavigationBarHeight (kStatusBarHeight + kNavBarHeight)
#define kSafeBottomHeight (kStatusBarHeight > 20 ? 34:0)
//#define kUIScreenHeight (kUIScreenSize.height - kSafeBottomHeight)
#define kUIScreenHeight kUIScreenSize.height
#define isIphoneX (kUIScreenSize.height == 812)

#define RSS(point) kUIScreenWidth/375*point

// 定义屏幕
#define IPHONE4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)


#define IPHONE6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 用户登录状态
#define kUserLogin [[NSUserDefaults standardUserDefaults] boolForKey:kUserLoginStateKey]

// 弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type

#define kWindow [UIApplication sharedApplication].keyWindow

//模块跳转
#define kGloableGood @"goods_id"
#define kGloableTopic @"topic_id"
#define kGloableCat @"cat_id"
#define kGloableArtical @"article_id"
#define kGloableKeyword @"keyword_id"


// 常量宏定义
UIKIT_EXTERN const CGFloat kMenuViewHeight;
UIKIT_EXTERN const CGFloat kGlobalPadding;
UIKIT_EXTERN const NSInteger kGlobalLimit;

UIKIT_EXTERN NSString *const kMJRefreshFooterTitle;

UIKIT_EXTERN NSString *const kPlaceholderLabelTextColor;

UIKIT_EXTERN NSString *const kUserLoginStateKey;
UIKIT_EXTERN NSString *const kUserTelKey;

UIKIT_EXTERN NSString *const kGesturePwdSwitchKey;
UIKIT_EXTERN NSString *const kGesturePwdNoticedKey;

UIKIT_EXTERN NSString *const kServiceName;

UIKIT_EXTERN NSString *const kNotificaticationUserInfo;

UIKIT_EXTERN NSString *const PaySucess;
UIKIT_EXTERN NSString *const PayFaliure;

// 通知
UIKIT_EXTERN NSString *const kCarDetailLaodFailed;

UIKIT_EXTERN NSString *const kCollectionCacelClick;


UIKIT_EXTERN NSString *const kUserInfoStateChangedNotification;
UIKIT_EXTERN NSString *const kUserLoginSuccessNotification;
UIKIT_EXTERN NSString *const kUserTokenFailNotification;
UIKIT_EXTERN NSString *const kResetPwdSuccessNotification;
UIKIT_EXTERN NSString *const kTransferChangedNotification;
UIKIT_EXTERN NSString *const kTimerFinishedNotification;
UIKIT_EXTERN NSString *const kOrderReloadNotification;
UIKIT_EXTERN NSString *const kTakeOverSuccessNotification;
UIKIT_EXTERN NSString *const kShopCartChangeNotification;


UIKIT_EXTERN NSString *const kAppID;
UIKIT_EXTERN NSString *const kBaseUrl;
UIKIT_EXTERN NSString *const kBaseImgUrl;
