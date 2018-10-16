//
//  BFDSexViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/23.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDSexViewController.h"

@interface BFDSexViewController ()

/** 0:男 1:女 */
@property (nonatomic, assign) int selecteType;

@end

@implementation BFDSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self congigureUI];
    [self setRightNavItemTitle:@"保存"];
}

-(void)congigureUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"性别";
    
    //男
    UIButton *maleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    maleBtn.frame = CGRectMake(RSS(63), RSS(160), RSS(250), RSS(75));
    [maleBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [maleBtn setTitle:@"男" forState:UIControlStateNormal];
    maleBtn.titleLabel.font = Font(RSS(18));
    maleBtn.layer.borderWidth = 1;
    maleBtn.layer.borderColor = RGBA(153, 153, 153, 1).CGColor;
    [self.view addSubview:maleBtn];
    
    //女
    UIButton *femaleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    femaleBtn.frame = CGRectMake(RSS(63), CGRectGetMaxY(maleBtn.frame) + RSS(70), RSS(250), RSS(75));
    [femaleBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    [femaleBtn setTitle:@"女" forState:UIControlStateNormal];
    femaleBtn.titleLabel.font = Font(RSS(18));
    femaleBtn.layer.borderWidth = 1;
    femaleBtn.layer.borderColor = RGBA(153, 153, 153, 1).CGColor;
    [self.view addSubview:femaleBtn];
    
    
    if ([[AccountTool sharedAccountTool].account.sex isEqualToString:@"男"]) {
        maleBtn.backgroundColor = RGBA(51, 51, 51, 1);
        [maleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        femaleBtn.backgroundColor = [UIColor whiteColor];
        [femaleBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        femaleBtn.layer.borderWidth = 1;
        femaleBtn.layer.borderColor = RGBA(153, 153, 153, 1).CGColor;
        self.selecteType = 0;
    }else{
        femaleBtn.backgroundColor = RGBA(51, 51, 51, 1);
        [femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        maleBtn.backgroundColor = [UIColor whiteColor];
        [maleBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        maleBtn.layer.borderWidth = 1;
        maleBtn.layer.borderColor = RGBA(153, 153, 153, 1).CGColor;
        self.selecteType = 1;
    }
    
    //点击事件
    [maleBtn click:^(id value) {
        maleBtn.backgroundColor = RGBA(51, 51, 51, 1);
        [maleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        femaleBtn.backgroundColor = [UIColor whiteColor];
        [femaleBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        femaleBtn.layer.borderWidth = 1;
        femaleBtn.layer.borderColor = RGBA(153, 153, 153, 1).CGColor;
        self.selecteType = 0;
    }];
    
    [femaleBtn click:^(id value) {
        femaleBtn.backgroundColor = RGBA(51, 51, 51, 1);
        [femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        maleBtn.backgroundColor = [UIColor whiteColor];
        [maleBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        maleBtn.layer.borderWidth = 1;
        maleBtn.layer.borderColor = RGBA(153, 153, 153, 1).CGColor;
        self.selecteType = 1;
    }];
}

- (void)setRightNavItemTitle:(NSString *)str {
    
    UIBarButtonItem *itembar = [[UIBarButtonItem alloc]initWithTitle:str style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    
    self.navigationItem.rightBarButtonItem = itembar;
}

-(void)rightClick{
    [self changeSex];
}


#pragma mark - 修改性别
-(void)changeSex{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:[NSString stringWithFormat:@"%d",self.selecteType] forKey:@"sex"];
    
    [JKHttpRequestService POST:@"/Home/Pcenter/pictureUpload" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            [BOCProgressHUD boc_showSuccess:responseObject[@"msg"]];
            
            Account *account = [AccountTool sharedAccountTool].account;
            account.sex = self.selecteType == 0 ? @"男" : @"女";
            [[AccountTool sharedAccountTool] saveAccount:account];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(void) {
        
    } animated:NO];
}
@end
