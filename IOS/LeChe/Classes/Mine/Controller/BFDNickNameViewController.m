//
//  BFDNickNameViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/23.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDNickNameViewController.h"

@interface BFDNickNameViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;

@property (nonatomic, copy) NSString *lastStr;

@end

@implementation BFDNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self congigureUI];
    [self setRightNavItemTitle:@"保存"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"NickNameView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"NickNameView"];
}

-(void)congigureUI{
    
    self.title = @"昵称";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nickNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nickNameTF.text = [AccountTool sharedAccountTool].account.nick_name;
    self.nickNameTF.delegate = self;
    [self.nickNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.nickNameTF];
}

- (void)setRightNavItemTitle:(NSString *)str {
    
    UIBarButtonItem *itembar = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    
    self.navigationItem.rightBarButtonItem = itembar;
}

-(void)rightClick{
    [self.view endEditing:YES];
    
    if (self.nickNameTF.text.length == 0) {
        [BOCProgressHUD boc_ShowError:@"请填写昵称"];
        return;
    }
    [self changeNickName];
}


#pragma mark - 输入限制
- (void)textFieldDidChange:(NSNotification *)note{
    
    //获取文本框内容的字节数
    int bytes = [self stringConvertToInt:self.nickNameTF.text];
    if (bytes > 12){
        self.nickNameTF.text = self.lastStr;
    }else{
        self.lastStr = self.nickNameTF.text;
    }
}

//得到字节数函数
-  (int)stringConvertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

#pragma mark - 修改昵称
-(void)changeNickName{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:self.nickNameTF.text forKey:@"nick_name"];
    
    [JKHttpRequestService POST:@"/Home/Pcenter/pictureUpload" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [BOCProgressHUD boc_showSuccess:responseObject[@"msg"]];
            
            Account *account = [AccountTool sharedAccountTool].account;
            account.nick_name = self.nickNameTF.text;
            [[AccountTool sharedAccountTool] saveAccount:account];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(void) {
        
    } animated:NO];
}


@end
