//
//  UIAlertController+Extension.h
//  ETong
//
//  Created by Remmo on 2017/4/1.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extension)

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle actionHandler:(void (^)(UIAlertAction *action))handler;

+ (instancetype)actionSheetWithTitle:(NSString *)title actionTitle:(NSString *)actionTitle actionType:(UIAlertActionStyle)actionType actionHandler:(void (^)(UIAlertAction *action))handler;

@end
