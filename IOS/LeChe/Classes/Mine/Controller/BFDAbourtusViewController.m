//
//  BFDAbourtusViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/4/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDAbourtusViewController.h"
#import <WebKit/WebKit.h>

@interface BFDAbourtusViewController ()

@end

@implementation BFDAbourtusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"关于我们";
    
    [self loadHtml];
}


- (void) loadHtml {
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight)];
    [self.view addSubview:webView];
    NSString        *path = @"http://testwww.rujcar.com/appAboutUs.html";
    NSURL           *url = [NSURL URLWithString:path];
    NSURLRequest    *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

@end
