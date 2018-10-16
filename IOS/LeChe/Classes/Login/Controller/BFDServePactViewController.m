//
//  BFDServePaceViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/5/8.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDServePactViewController.h"

@interface BFDServePactViewController ()

@end

@implementation BFDServePactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"如鲸购车用户注册使用协议";
    
    //初始化myWebView
    UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight)];
    myWebView.backgroundColor = [UIColor whiteColor];
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"agreement.html" withExtension:nil];//
    NSURLRequest *request = [NSURLRequest requestWithURL: filePath];
    [myWebView loadRequest:request];
    [self.view addSubview:myWebView];
}


@end
