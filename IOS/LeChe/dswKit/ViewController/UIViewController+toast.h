//
//  UIViewController+toast.h
//  qtyd
//
//  Created by stephendsw on 15/8/21.
//  Copyright (c) 2015年 qtyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (toast)

#pragma mark - other

- (void)showMeg:(NSString *)meg;

- (void)showMeg:(NSString *)meg cancelTitle:(NSString *)str;

- (void)showMeg:(NSString *)meg block:(alertBlock)block;

- (void)showMeg:(NSString *)meg cancelTitle:(NSString *)str block:(alertBlock)block;

/**
 *  显示提示信息
 */

- (void)showToast:(NSString *)msg;

- (void)showToast:(NSString *)msg duration:(unsigned int)val;

- (void)showToast:(NSString *)msg done:(void (^)(void))blcok;

- (void)showToast:(NSString *)msg duration:(unsigned int)val done:(void (^)(void))blcok;

#pragma mark - HUD
- (void)showHUD:(NSString *)meg;
- (void)showHUD;
- (void)hideHUD;

- (void)showCustomHUD:(UIView *)view;

- (void)hideCustomHUB;

@end
