//
//  ShowLoginManager.h
//  ETong
//
//  Created by Remmo on 16/12/22.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowLoginManager : NSObject

+ (void)showLoginVcFrom:(UIViewController *)viewController isTokenFailed:(BOOL)isTokenFailed;
+ (void)showLoginVcFromView:(UIView *)view;

@end
