//
//  UIAlertController+Extension.m
//  ETong
//
//  Created by Remmo on 2017/4/1.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import "UIAlertController+Extension.h"

@implementation UIAlertController (Extension)

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle actionHandler:(void (^)(UIAlertAction *action))handler
{

    return [self alertVcWithTitle:title message:message actionTitle:actionTitle actionType:UIAlertActionStyleDefault actionHandler:handler preferredStyle:UIAlertControllerStyleAlert];
}

+ (instancetype)actionSheetWithTitle:(NSString *)title actionTitle:(NSString *)actionTitle actionType:(UIAlertActionStyle)actionType actionHandler:(void (^)(UIAlertAction *action))handler
{
    return [self alertVcWithTitle:title message:nil actionTitle:actionTitle actionType:actionType actionHandler:handler preferredStyle:UIAlertControllerStyleActionSheet];
}

+ (instancetype)alertVcWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle actionType:(UIAlertActionStyle)actionType actionHandler:(void (^)(UIAlertAction *action))handler preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionAction = [UIAlertAction actionWithTitle:actionTitle style:actionType handler: handler];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:actionAction];
    
    return alertVC;
}

@end
