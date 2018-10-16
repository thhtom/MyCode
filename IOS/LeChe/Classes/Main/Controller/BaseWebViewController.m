//
//  BaseWebViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/2/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWebView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClicked)];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backItemClicked
{
    if (self.enableWebBack && [self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loadWebViewWith:(NSString *)urlString
{
    NSString *formatUrlStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:formatUrlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIView alloc]initWithFrame:CGRectZero];
        //进度条的y值根据导航条是否透明会有变化
        _progressView.y = 0;
        _progressView.height = 2.0;
        _progressView.backgroundColor = RGBA(232, 202, 126, 1);
    }
    return _progressView;
}

- (void)progressValueMonitor
{
    [self.view addSubview:self.progressView];
    self.progressView.width = kUIScreenWidth * self.webView.estimatedProgress;
}

- (void)setupWebView
{
    WKWebView *webView = [[WKWebView alloc]init];
    webView.frame = self.webViewFrame.size.width == 0 ? CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight): self.webViewFrame;
    webView.backgroundColor = kGlobalBg;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    if (self.urlString) {
        [self loadWebViewWith:self.urlString];
    }
}

- (void)setWebViewFrame:(CGRect)webViewFrame
{
    _webViewFrame = webViewFrame;
    self.webView.frame = webViewFrame;
    self.progressView.y = webViewFrame.origin.y;
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressValueMonitor)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.navigationItem.title = (webView.title.length > 0) ? webView.title : @"关于我们";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self.displayLink invalidate];
    [UIView animateWithDuration:0.2 animations:^{
        self.progressView.width = kUIScreenWidth;
    } completion:^(BOOL finished) {
        [self.progressView removeFromSuperview];
    }];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.progressView.width = kUIScreenWidth;
    } completion:^(BOOL finished) {
        [self.progressView removeFromSuperview];
    }];
    [self.displayLink invalidate];
    if([error code] == NSURLErrorCancelled) return;
    //    [MBProgressHUD showError:@"网络不给力" toView:self.view];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.progressView.width = kUIScreenWidth;
    } completion:^(BOOL finished) {
        [self.progressView removeFromSuperview];
    }];
    [self.displayLink invalidate];
    if([error code] == NSURLErrorCancelled) return;
    //    [MBProgressHUD showError:@"网络不给力" toView:self.view];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
