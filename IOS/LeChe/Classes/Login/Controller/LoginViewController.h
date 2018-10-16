//
//  LoginViewController.h
//  LeChe
//
//  Created by yangxuran on 2018/2/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

/** 是否是token失效 */
@property (nonatomic, assign) BOOL isTokenFailed;
@property (nonatomic, strong) UIViewController *fromVC;

@end
