//
//  Constant.m
//
//  Created by yangxuran on 2018/2/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "Constant.h"

const CGFloat kMenuViewHeight = 44.0;
const CGFloat kGlobalPadding = 10.0;
const NSInteger kGlobalLimit = 10;

NSString *const kMJRefreshFooterTitle = @"已经到底啦";

NSString *const kPlaceholderLabelTextColor = @"_placeholderLabel.textColor";
NSString *const kUserLoginStateKey = @"UserLoginStateKey";
NSString *const kUserTelKey = @"kUserTelKey";

NSString *const kGesturePwdSwitchKey = @"kGesturePwdSwitchKey";
NSString *const kGesturePwdNoticedKey = @"kGesturePwdNoticedKey";
NSString *const kServiceName = @"kServiceName";

NSString *const kNotificaticationUserInfo = @"kNotificaticationUserInfo";

NSString *const PaySucess = @"PaySucess";
NSString *const PayFaliure = @"PayFaliure";

///TODO:通知
NSString *const kCarDetailLaodFailed = @"kCarDetailLaodFailed";

NSString *const kCollectionCacelClick = @"MyCollectionRightBtnClick";


NSString *const kUserInfoStateChangedNotification = @"UserInfoStateChangedNotification";
NSString *const kUserLoginSuccessNotification = @"UserLoginSuccessNotification";
NSString *const kUserTokenFailNotification = @"UserTokenFailNotification";
NSString *const kResetPwdSuccessNotification = @"ResetPwdSuccessNotification";
NSString *const kTransferChangedNotification = @"TransferChangedNotification";
NSString *const kTimerFinishedNotification = @"TimerFinishedNotification";
NSString *const kOrderReloadNotification = @"OrderReloadNotification";
NSString *const kTakeOverSuccessNotification = @"TakeOverSuccessNotification";
NSString *const kShopCartChangeNotification = @"kShopCartChangeNotification";

NSString *const kAppID = @"1383092992";


#ifdef DEBUG
    NSString *const kBaseUrl = @"http://testapi.rujcar.com";
    NSString *const kBaseImgUrl = @"http://testadmin.rujcar.com";

//    NSString *const kBaseUrl = @"https://api.rujcar.com";
//    NSString *const kBaseImgUrl = @"https://admin.rujcar.com";
#else
    NSString *const kBaseUrl = @"https://api.rujcar.com";
    NSString *const kBaseImgUrl = @"https://admin.rujcar.com";
#endif



