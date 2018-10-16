//
//  BFDLoginSecondViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/20.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDLoginSecondViewController.h"
#import "VerificationCodeView.h"
#import "BFDHomeDetailViewController.h"
#import "BFDPriceDetailViewController.h"

@interface BFDLoginSecondViewController (){
    NSString *_codeStr;
    int _timeout;
}

@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation BFDLoginSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(22, 22, 22, 1);
    
    self.codeView.width = kUIScreenWidth - 38 * 2;
    self.loginBtn.width = kUIScreenWidth - 38 * 2;
    VerificationCodeView *codeView = [[VerificationCodeView alloc] initWithFrame:self.codeView.bounds andLabelCount:4];
    codeView.backgroundColor = [UIColor clearColor];
    codeView.codeBlock = ^(NSString *codeStr) {
        self->_codeStr = codeStr;
    };
    [self.codeView addSubview:codeView];
    [codeView.codeTextField becomeFirstResponder];
    
    [self.loginBtn addGradient];
    
    [self.codeBtn click:^(id value) {
        if ([self.phone isEqualToString:@"15201038400"]) {
            [BOCProgressHUD boc_showText:@"当前验证码为1111"];
            return ;
        }
        [self getCode];
        [self startResidualTimer];
    }];
    
    if ([self.phone isEqualToString:@"15201038400"]) {
        return;
    }
    
    [self startResidualTimer];
    [self getCode];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.alpha = 0;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.alpha = 1;
}

#pragma mark - 返回
- (IBAction)cancelBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 登录
- (IBAction)loginBtnClick:(id)sender {
    if (_codeStr.length < 4) {
        [BOCProgressHUD boc_ShowError:@"验证码格式错误"];
        return;
    }
    
    [self.view endEditing:YES];
    _timeout = 0;
    self.codeBtn.userInteractionEnabled = YES;
    
    [self login];
}


#pragma mark - 获取验证码
-(void)getCode{
    [BOCProgressHUD boc_ShowHUD];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.phone forKey:@"mobile"];
    [JKHttpRequestService POST:@"/Home/Register/short_message_send" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [BOCProgressHUD boc_hiddenHUD];
        [BOCProgressHUD boc_showSuccess:@"验证码发送成功"];
    } failure:^(void) {
        [BOCProgressHUD boc_hiddenHUD];
    } animated:NO];
}

//登录
-(void)login{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.phone forKey:@"mobile"];
    [params setObject:_codeStr forKey:@"sms_code"];
    [params setObject:@"IOS" forKey:@"device_port"];
    
    [JKHttpRequestService POST:@"/Home/Register/login" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        
        if (succe) {
            //保存用户信息
            Account *account = [Account mj_objectWithKeyValues:responseObject[@"data"]];
            [[AccountTool sharedAccountTool] saveAccount:account];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserLoginStateKey];
            
            if ([self.fromVC isKindOfClass:[BFDHomeDetailViewController class]] || [self.fromVC isKindOfClass:[BFDPriceDetailViewController class]]) {
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginSuccessNotification object:nil];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(void) {
        
    } animated:NO];
}


//开启倒计时
- (void)startResidualTimer {
    self.codeBtn.userInteractionEnabled = NO;
    self.codeBtn.backgroundColor = RGBColor(204, 204, 204);
    _timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(self->_timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.codeBtn.userInteractionEnabled = YES;
                [self.codeBtn setTitle:@"重发" forState:UIControlStateNormal];
                self.codeBtn.backgroundColor = RGBA(51, 51, 51, 1);
            });
        }else{
            int seconds = self->_timeout ;
            NSString *strTime = [NSString stringWithFormat:@"重发  (%dS)", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBtn setTitle:strTime forState:UIControlStateNormal];
                self.codeBtn.layer.borderWidth = 1;
                self.codeBtn.layer.borderColor = RGBA(102, 102, 102, 1).CGColor;
                self.codeBtn.backgroundColor = [UIColor clearColor];
                [self.codeBtn setTitleColor:RGBA(102, 102, 102, 1) forState:UIControlStateNormal];
            });
            self->_timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end
