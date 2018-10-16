//
//  BFDReserveViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDReserveViewController.h"
#import "CarSitePickerView.h"
#import "TimePickerView.h"
#import "BFDSiteModel.h"
#import "BFDMyReserveModel.h"
#import "BFDMyReserveViewController.h"
#import "CityPickerView.h"
#import <IQKeyboardManager.h>

@interface BFDReserveViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property (weak, nonatomic) IBOutlet UITextField *siteTF;
@property (weak, nonatomic) IBOutlet UIButton *yuyueBtn;

@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation BFDReserveViewController

#pragma mark - 懒加载
-(NSMutableArray *)dataAry{
    if (!_dataAry) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"UMengTongJi"];
    
    [self congigureUI];
    [self getReserveList];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"ReserveView"];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ReserveView"];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}


-(void)congigureUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"预约看车";
    
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneTF.delegate = self;
    self.timeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.timeTF.delegate = self;
    self.siteTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.siteTF.delegate = self;
    
    self.yuyueBtn.width = kUIScreenWidth;
    [self.yuyueBtn addGradient];
    
    if (self.model) {
        self.nameTF.text = self.model.reservations_name;
        self.phoneTF.text = self.model.reservations_phone;
        self.timeTF.text = self.model.ctime;
        self.siteTF.text = self.model.shopname;
    }
}


#pragma mark - 立即预约
- (IBAction)reserveBtnClick:(id)sender {
    if (self.nameTF.text.length == 0 || self.phoneTF.text.length == 0 || self.timeTF.text.length == 0 || self.siteTF.text.length == 0) {
        [BOCProgressHUD boc_ShowError:@"请输入完整信息"];
        return;
    }
    if (![self.phoneTF.text valiMobile]) {
        [BOCProgressHUD boc_ShowError:@"手机格式错误"];
        return;
    }
    
    [self reserve];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.siteTF) {
        [self.view endEditing:YES];
        
        CarSitePickerView *siteView = [[CarSitePickerView alloc] initWithFrame:kWindow.bounds dataAry:self.dataAry];
        [siteView setAction:^(NSString *site) {
            self.siteTF.text = site;
        }];
        [siteView showView];
        
//        CityPickerView *cityView = [[CityPickerView alloc] initWithFrame:kWindow.bounds];
//        [cityView showView];
//        cityView.action = ^(NSString *city) {
//            self.siteTF.text = city;
//        };
        
        return NO;
    }else if (textField == self.timeTF){
        [self.phoneTF resignFirstResponder];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        TimePickerView *datePicker = [[TimePickerView alloc]initWithDateFormatter:formatter pickerMode:UIDatePickerModeDate delegate:nil];
        datePicker.minDate = [NSDate date];
        [datePicker showView];
        
        datePicker.dateStrBlock = ^(NSString *dateStr){
            self.timeTF.text = dateStr;
        };
        
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneTF) {
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

#pragma mark - 门店列表
-(void)getReserveList{
    
    [BOCProgressHUD boc_ShowHUD];
    
    NSString *good_id = self.model ? self.model.goods_id : self.good_id;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:good_id forKey:@"goods_id"];
    
    [JKHttpRequestService POST:@"/Home/Reservation/getAddress" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [BOCProgressHUD boc_hiddenHUD];
        if (succe) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                BFDSiteModel *model = [BFDSiteModel mj_objectWithKeyValues:dic];
                [self.dataAry addObject:model];
            }
        }
    } failure:^(void) {
        [BOCProgressHUD boc_hiddenHUD];
    } animated:NO];
}

#pragma mark - 预约
-(void)reserve{
    
    NSString *good_id = self.model ? self.model.goods_id : self.good_id;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:self.nameTF.text forKey:@"reservations_name"];
    [params setObject:self.phoneTF.text forKey:@"reservations_phone"];
    [params setObject:self.timeTF.text forKey:@"ctime"];
    [params setObject:self.siteTF.text forKey:@"address_id"];
//    [params setObject:self.siteTF.text forKey:@"site"];
    
    [params setObject:good_id forKey:@"goods_id"];
    if (self.model) {
        [params setObject:self.model.reservation_number forKey:@"reservation_number"];
    }
    
    [JKHttpRequestService POST:@"/Home/Reservation/addReservation" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
    
        if (succe) {
            [MobClick event:@"successfully"];
            [BOCProgressHUD boc_showSuccess:responseObject[@"msg"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.model) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    BFDMyReserveViewController *myReserveVC = [[BFDMyReserveViewController alloc] init];
                    [self.navigationController pushViewController:myReserveVC animated:YES];
                }
            });
        }
    } failure:^(void) {
        
    } animated:NO];
}

@end
