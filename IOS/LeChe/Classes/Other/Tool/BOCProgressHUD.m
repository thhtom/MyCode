//
//  BOCProgressHUD.m
//  ToTLive
//
//  Created by Remmo on 2017/4/24.
//

#import "BOCProgressHUD.h"

@implementation BOCProgressHUD

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.minimumDismissTimeInterval = 0.5;
        self.maximumDismissTimeInterval = 1;
        self.defaultMaskType = SVProgressHUDMaskTypeClear;
    }
    return self;
}

+ (void)load {
    self.minimumDismissTimeInterval = 0.5;
    self.maximumDismissTimeInterval = 1;
    self.defaultMaskType = SVProgressHUDMaskTypeClear;
}

+ (void)boc_ShowInfo:(NSString *)status
{
    [self boc_ShowInfo:status style:SVProgressHUDStyleDark];
}

+ (void)boc_showSuccess:(NSString *)status
{
    [self boc_showSuccess:status style:SVProgressHUDStyleDark];
}

+ (void)boc_ShowError:(NSString *)status
{
    [self boc_ShowError:status style:SVProgressHUDStyleDark];
}

+ (void)boc_ShowHUD:(NSString *)status
{
    [self boc_ShowHUD:status style:SVProgressHUDStyleDark];
}

+ (void)boc_ShowHUD
{
    [self boc_ShowHUD:nil];
}

+ (void)boc_showText:(NSString *)status {
    [self setInfoImage:[UIImage imageNamed:@""]];
    [self setCornerRadius:5.0];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self showInfoWithStatus:status];
}

+ (void)boc_ShowInfo:(NSString *)status style:(SVProgressHUDStyle)style
{
    [self setDefaultStyle:style];
    [self showInfoWithStatus:status];
}

+ (void)boc_showSuccess:(NSString *)status style:(SVProgressHUDStyle)style
{
    [self setDefaultStyle:style];
    [self showSuccessWithStatus:status];
}

+ (void)boc_ShowError:(NSString *)status style:(SVProgressHUDStyle)style
{
    [self setDefaultStyle:style];
    [self showErrorWithStatus:status];
}

+ (void)boc_ShowHUD:(NSString *)status style:(SVProgressHUDStyle)style
{
    [self setDefaultStyle:style];
    [self showWithStatus:status];
}

+ (void)boc_hiddenHUD
{
    [self dismiss];
}


@end

