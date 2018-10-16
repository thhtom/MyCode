//
//  BFDNewsDetailViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/5/14.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDNewsDetailViewController.h"

@interface BFDNewsDetailViewController ()

@property (nonatomic, weak) UITextView *textView;

@end

@implementation BFDNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"汽车资讯";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
}

#pragma mark - 数据
-(void)getData{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.a_id forKey:@"a_id"];
    
    [JKHttpRequestService POST:@"/Home/Article/articleDetails" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        
        if (succe) {
            UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight)];
            [self.view addSubview:webview];
            [webview loadHTMLString:jsonDic[@"data"][@"content"] baseURL:nil];
        }
    } failure:^(void) {
        
    } animated:NO];
}

@end
