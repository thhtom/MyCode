//
//  LoginViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/2/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "LoginViewController.h"
#import "BFDLoginSecondViewController.h"
#import "BFDServePactViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *protocolImg;
@property (nonatomic, weak) UIButton *protocolBtn;
@property (nonatomic, weak) UITextField *textField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(22, 22, 22, 1);
    [self createUI];
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

-(void)createUI{
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(RSS(132), RSS(114), RSS(110), RSS(110))];
    imgView.image = Img(@"logo_clean");
    [self.view addSubview:imgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(RSS(37), CGRectGetMaxY(imgView.frame) + RSS(75), RSS(300), RSS(30))];
    textField.font = Font(RSS(16));
    textField.textColor = [UIColor whiteColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"请输入手机号";
    [textField setValue:RGBA(220, 220, 220, 1) forKeyPath:@"_placeholderLabel.textColor"];
    textField.tintColor = [UIColor whiteColor];
    [self.view addSubview:textField];
    self.textField = textField;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(RSS(37), CGRectGetMaxY(textField.frame), RSS(300), 0.5)];
    lineView.backgroundColor = RGBA(204, 204, 204, 1);
    [self.view addSubview:lineView];
    
    
    UIImageView *protocolImg = [[UIImageView alloc] initWithFrame:CGRectMake(RSS(37), CGRectGetMaxY(lineView.frame) + RSS(25), RSS(13), RSS(13))];
    protocolImg.image = Img(@"uncheck");
    [self.view addSubview:protocolImg];
    self.protocolImg = protocolImg;
    
    UILabel *protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(protocolImg.frame) + RSS(8), CGRectGetMaxY(lineView.frame) + RSS(26), RSS(225), RSS(12))];
    protocolLabel.textColor = RGBA(153, 153, 153, 1);
    protocolLabel.font = Font(RSS(12));
    NSString *str = @"我已阅读并同意《如鲸用户服务协议》";
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attriStr setAttributes:@{NSForegroundColorAttributeName: RGBA(232, 202, 126, 1)} range:NSMakeRange(7, 10)];
    protocolLabel.attributedText = attriStr;
    //服务协议
    [protocolLabel addTapGesture:^{
        BFDServePactViewController *servePactVC = [[BFDServePactViewController alloc] init];
        [self.navigationController pushViewController:servePactVC animated:YES];
    }];
    [self.view addSubview:protocolLabel];
    
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    protocolBtn.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame) + 10, 50, 40);
    protocolBtn.backgroundColor = [UIColor clearColor];
    [protocolBtn addTarget:self action:@selector(proticolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocolBtn];
    self.protocolBtn = protocolBtn;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(RSS(37), CGRectGetMaxY(protocolLabel.frame) + RSS(19), RSS(300), RSS(49));
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [nextBtn addGradient];
    [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    UILabel *lookAroundLabel = [QuickCreate createLabelWithFrame:CGRectMake(RSS(152), CGRectGetMaxY(nextBtn.frame) + RSS(20), RSS(75), RSS(30)) text:@"随便看看" textColor:RGBA(232, 202, 126, 1) fontSize:RSS(16) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
    [self.view addSubview:lookAroundLabel];
    //随便看看
    [lookAroundLabel addTapGesture:^{
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.isTokenFailed) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserTokenFailNotification object:nil];
        }
    }];
    
    UILabel *label = [QuickCreate createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(lookAroundLabel.frame) + RSS(155), kUIScreenWidth, RSS(12)) text:@"无需注册，快捷登录" textColor:RGBA(51, 51, 51, 1) fontSize:RSS(12) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
    [self.view addSubview:label];
    
}

#pragma mark - 同意协议
-(void)proticolBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.protocolImg.image = Img(@"check");
    }else{
        self.protocolImg.image = Img(@"uncheck");
    }
}

#pragma mark - 下一步按钮
-(void)nextClick:(UIButton *)btn{
    
    if (!self.protocolBtn.selected) {
        [BOCProgressHUD boc_ShowError:@"请先同意用户服务协议"];
        return;
    }
    
    if (![self.textField.text valiMobile]) {
        [BOCProgressHUD boc_ShowError:@"手机格式错误"];
        return;
    }
    
    BFDLoginSecondViewController *loginSecondVC = [[BFDLoginSecondViewController alloc] init];
    loginSecondVC.fromVC = self.fromVC;
    loginSecondVC.phone = self.textField.text;
    [self.navigationController pushViewController:loginSecondVC animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.textField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}

@end
