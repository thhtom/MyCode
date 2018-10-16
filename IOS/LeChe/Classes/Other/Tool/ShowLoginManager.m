//
//  ShowLoginManager.m
//  ETong
//
//  Created by Remmo on 16/12/22.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import "ShowLoginManager.h"

#import "MainNavigationController.h"
#import "LoginViewController.h"

#import "UIView+ViewController.h"

@implementation ShowLoginManager

+ (void)showLoginVcFrom:(UIViewController *)viewController isTokenFailed:(BOOL)isTokenFailed
{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    loginVC.isTokenFailed = isTokenFailed;
    loginVC.fromVC = viewController;
    MainNavigationController *loginNav = [[MainNavigationController alloc]initWithRootViewController:loginVC];
    [viewController presentViewController:loginNav animated:YES completion:nil];
}

+ (void)showLoginVcFromView:(UIView *)view
{
//    [self showLoginVcFrom:[view getViewController]];
}

@end
