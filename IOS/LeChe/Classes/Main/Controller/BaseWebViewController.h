//
//  BaseWebViewController.h
//  LeChe
//
//  Created by yangxuran on 2018/2/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaseWebViewController : UIViewController<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, copy) NSString *urlString;

- (void)loadWebViewWith:(NSString *)urlString;

/**
 *  监听webView是否可返回，做webview的返回操作, 默认为NO
 */
@property (nonatomic, assign) BOOL  enableWebBack;

/**
 *  可以调整webView的frame
 */
@property (nonatomic, assign) CGRect webViewFrame;

@property (nonatomic, weak) WKWebView *webView;

@end
