//
//  BOCProgressHUD.h
//  ToTLive
//
//  Created by Remmo on 2017/4/24.
//

#import "SVProgressHUD.h"

@interface BOCProgressHUD : SVProgressHUD

+ (void)boc_ShowInfo:(NSString *)status;
+ (void)boc_showSuccess:(NSString *)status;
+ (void)boc_ShowError:(NSString *)status;
+ (void)boc_ShowHUD:(NSString *)status;
+ (void)boc_ShowHUD;
+ (void)boc_showText:(NSString *)status;

+ (void)boc_ShowInfo:(NSString *)status style:(SVProgressHUDStyle)style;
+ (void)boc_showSuccess:(NSString *)status style:(SVProgressHUDStyle)style;
+ (void)boc_ShowError:(NSString *)status style:(SVProgressHUDStyle)style;
+ (void)boc_ShowHUD:(NSString *)status style:(SVProgressHUDStyle)style;

+ (void)boc_hiddenHUD;

@end

