//
//  JKHttpRequestService.m
//  shopsN
//
//  Created by imac on 2017/2/10.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "JKHttpRequestService.h"
#import "Constant.h"
#import "UIViewController+Push.h"

@implementation JKHttpRequestService

+(void)POST:(NSString *)path withParameters:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated{
    if (animated) {

    }
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,path];
    NSLog(@"post:path===%@\n%@",url,params);
    
    //请求头
    [params setValue:[@"如鲸租车" base64String] forKey:@"access_id"];
    [params setValue:@"ios" forKey:@"device_port"];
    [params setValue:@"V2.0" forKey:@"api_version"];
    if (kUserLogin) {
        [params setValue:[AccountTool sharedAccountTool].account.token forKey:@"token"];
    }
    
    [[JKHttpClientTool sharedManager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }
        if (succe) {
            success(responseObject,succe,dic);
        }else{
            [BOCProgressHUD boc_ShowError:responseObject[@"msg"]];
            
            if ([str isEqualToString:@"401"]) {//登录失效
                [ShowLoginManager showLoginVcFrom:kWindow.rootViewController isTokenFailed:YES];
                //清空用户信息
                Account *account = nil;
                [[AccountTool sharedAccountTool] saveAccount:account];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kUserLoginStateKey];
            }
            
            //车辆详情页加载出错
            [[NSNotificationCenter defaultCenter] postNotificationName:kCarDetailLaodFailed object:nil];
        }
        NSLog(@"%@",dic[@"data"]);
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        fail();
        [BOCProgressHUD boc_ShowError:@"网络故障"];
    }];
}


+(void)POST:(NSString *)path Params:(NSDictionary *)params NSData:(NSData *)imageData key:(NSString *)name success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated{

    [params setValue:[@"如鲸租车" base64String] forKey:@"access_id"];
    [params setValue:@"ios" forKey:@"device_port"];
    [params setValue:@"V2.0" forKey:@"api_version"];
    if (kUserLogin) {
        [params setValue:[AccountTool sharedAccountTool].account.token forKey:@"token"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,path];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSLog(@"path ==%@%@",url,params);
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        if (imageData) {
            NSString *file  =[NSString stringWithFormat:@"%@.jpg",imageData];
            [formData appendPartWithFileData:imageData name:name fileName:file mimeType:@"image/png/jpeg/jpg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:&error];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }
        
        if (succe) {
            success(responseObject,succe,dic);
        }else{
            [BOCProgressHUD boc_ShowError:responseObject[@"msg"]];
            fail();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail();
        [BOCProgressHUD boc_ShowError:@"网络故障"];
    }];
}

+ (void)POST:(NSString *)path Params:(NSDictionary*)params NSArray:(NSArray<NSData*>*)imageArr key:(NSArray<NSString*>*)nameArr success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated{
    
    [params setValue:[@"如鲸租车" base64String] forKey:@"access_id"];
    [params setValue:@"ios" forKey:@"device_port"];
    [params setValue:@"V2.0" forKey:@"api_version"];
    if (kUserLogin) {
        [params setValue:[AccountTool sharedAccountTool].account.token forKey:@"token"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,path];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSLog(@"path ==%@%@",url,params);
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        if (imageArr.count) {
            for (int i=0; i<imageArr.count; i++) {
                NSData *data = imageArr[i];
                NSString *name = nameArr[i];
                NSString *file  =[NSString stringWithFormat:@"%@.jpg",data];
                [formData appendPartWithFileData:data name:name fileName:file mimeType:@"image/png/jpeg/jpg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:&error];
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
        BOOL succe=NO;
        if ([str isEqualToString:@"1"]) {
            succe = YES;
        }

        if (succe) {
            success(responseObject,succe,dic);
        }else{
            [BOCProgressHUD boc_ShowError:responseObject[@"msg"]];
            fail();
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail();
        [BOCProgressHUD boc_ShowError:@"网络故障"];
    }];
}

+ (void)payPost:(NSString *)path Params:(NSDictionary *)params success:(SuccessCallBack)success failure:(FailureCallBack)fail animated:(BOOL)animated {
    
    [params setValue:[@"如鲸租车" base64String] forKey:@"access_id"];
    if (kUserLogin) {
        [params setValue:[AccountTool sharedAccountTool].account.token forKey:@"token"];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,path];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.requestSerializer.timeoutInterval = 30;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSLog(@"path ==%@%@",url,params);
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
//            [SXLoadingView hideProgressHUD];
            NSError *error;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *str = [NSString stringWithFormat:@"%@",dic[@"status"]];
            BOOL succe=NO;
            if ([str isEqualToString:@"1"]) {
                succe = YES;
            }

            if (succe) {
                //            [SXLoadingView showAlertHUD:@"加载成功" duration:SXLoadingTime];
            }else{
//                [SXLoadingView showAlertHUD:[dic valueForKey:@"message"] duration:SXLoadingTime];
            }
            NSLog(@"%@",dic[@"data"]);
            success(responseObject,succe,dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (animated) {
//            [SXLoadingView hideProgressHUD];
        }
        NSLog(@"%@",error.description);
        fail();
    }];
}

- (UIViewController *) topViewController {
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *) topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


@end
