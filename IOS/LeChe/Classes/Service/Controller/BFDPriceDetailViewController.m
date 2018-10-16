//
//  BFDPriceDetailViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDPriceDetailViewController.h"
#import "CarModel.h"
#import "BFDMyCollectionModel.h"
#import "BFDReserveViewController.h"
#import "BFDMyReserveViewController.h"
#import "XRSlider.h"

static CGFloat const bottomHeight = 50;

@interface BFDPriceDetailViewController ()

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstDetailLabel;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *firstPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthPayLabel;
@property (weak, nonatomic) IBOutlet UIView *firstPayView;
@property (weak, nonatomic) IBOutlet UIView *monthPayView;

@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *reserveBtn;

/** slider相关 */
@property (nonatomic, weak) XRSlider *firstSlider;
@property (nonatomic, weak) XRSlider *monthSlider;
@property (nonatomic, strong) NSArray *firstAry; //首付百分比
@property (nonatomic, strong) NSArray *monthAry; //期数
@property (nonatomic, assign) CGFloat percent;   //首付百分比
@property (nonatomic, assign) int periods;       //期数
@property (nonatomic, strong) NSDictionary *detailDic;

@end

@implementation BFDPriceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(245, 245, 245, 1);
    self.title = @"计价详情";
    
    self.firstAry = @[@"20%",@"30%",@"40%",@"50%"];
    self.monthAry = @[@"12期",@"18期",@"24期",@"30期",@"36期",@"42期",@"48期"];
    
    [self createScrollView];
    [self configureUI];
    [self getData];
    [self btnClick];
    [self setRightBarButtonItem];
    
    self.bottomView.frame = CGRectMake(0, kUIScreenHeight - kNavigationBarHeight - bottomHeight - kSafeBottomHeight, kUIScreenWidth, bottomHeight);
    [self.view addSubview:self.bottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kUserLoginSuccessNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.fd_interactivePopDisabled = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.fd_interactivePopDisabled = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"CalculatorDetailCarView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CalculatorDetailCarView"];
}

-(void)loginSuccess{
    [self getData];
}

-(void)setRightBarButtonItem{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 44);
    [btn setImage:Img(@"serve_changeCar") forState:UIControlStateNormal];
    //更换车辆
    [btn addTapGesture:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)createScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight - bottomHeight - kSafeBottomHeight)];
    [self.view addSubview:scrollView];
    
    self.headerView.frame = CGRectMake(0, 0, kUIScreenWidth, 268);
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame) + 8, kUIScreenWidth, 380);
    
    //首付比例
    XRSlider *firstSlider = [[XRSlider alloc] initWithFrame:CGRectMake(0, 0, self.firstPayView.width, self.firstPayView.height) titleAry:self.firstAry];
    
    firstSlider.valueChangeBlock = ^(NSInteger index) {
        //选择的首付百分比
        NSString *str = self.firstAry[index];
        self.percent = [[str substringToIndex:str.length - 1] intValue];
        
        [self configDataAfterSlider];
    };
    self.firstSlider = firstSlider;
    [self.firstPayView addSubview:firstSlider];
    
    //月供期数
    XRSlider *monthSlider = [[XRSlider alloc] initWithFrame:CGRectMake(0, 0, self.monthPayView.width, self.monthPayView.height) titleAry:self.monthAry];
    
    monthSlider.valueChangeBlock = ^(NSInteger index) {
        //选择的期数
        NSString *str = self.monthAry[index];
        self.periods = [[str substringToIndex:str.length - 1] intValue];
        
        [self configDataAfterSlider];
    };
    self.monthSlider = monthSlider;
    [self.monthPayView addSubview:monthSlider];
    
    //提示
    UILabel *label = [QuickCreate createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentView.frame) + 30, kUIScreenWidth, 20) text:@"仅供参考，具体信息请去门店或联系客服咨询详情。" textColor:RGBA(204, 204, 204, 1) fontSize:RSS(13) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
    
    [scrollView addSubview:self.headerView];
    [scrollView addSubview:self.contentView];
    [scrollView addSubview:label];
    
    scrollView.contentSize = CGSizeMake(kUIScreenWidth, CGRectGetMaxY(self.contentView.frame) + 60);
}

-(void)configureUI{
    
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.layer.shadowColor = RGBA(245, 245, 245, 1).CGColor;
    self.headerView.layer.shadowOpacity = 1;
    self.headerView.layer.shadowOffset = CGSizeMake(0, 8);
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.shadowColor = RGBA(245, 245, 245, 1).CGColor;
    self.contentView.layer.shadowOpacity = 1;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 8);
    
    if (kUIScreenWidth == 320) {
        self.firstDetailLabel.font = [UIFont systemFontOfSize:10];
    }
    
    [self.reserveBtn buttonAddGradinet];
}

#pragma mark - 赋值
//设置初始值
-(void)configureData:(NSDictionary *)dataDic{
    
    NSInteger index = ([dataDic[@"price_member"] floatValue] * 100 - 20) / 10;
    if (index >= self.firstAry.count || index < 0) {
        index = 0;
    }
    [self.firstSlider setSelectIndex:index];
    [self.monthSlider setSelectIndex:([dataDic[@"weight"] integerValue] - 12) /6];
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImgUrl,dataDic[@"pic_url"]]] placeholderImage:Img(@"banner_placeholder")];
    self.titleLabel.text = dataDic[@"title"];

    self.priceLabel.text = [NSString stringWithFormat:@"官方指导价：%.2f万",[self.detailDic[@"price_market"] floatValue] / 10000];
    
    //即将上市
    if ([dataDic[@"status"] isEqualToString:@"8"]) {
        //修改按钮样式
        [self.reserveBtn setTitle:@"敬请期待" forState:UIControlStateNormal];
    }else{
        if ([dataDic[@"appointment"] boolValue]) {
            [self.reserveBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            
        }else{
            [self.reserveBtn setTitle:@"立即预约" forState:UIControlStateNormal];
        }
    }
}


//slider选择后赋值
-(void)configDataAfterSlider{
    
    //裸车价
    CGFloat price = [self.detailDic[@"price_market"] floatValue];
    //总价
    CGFloat allprice = [self.detailDic[@"car_total_price"] floatValue];
    //首付   (裸车价 * 首付比例)
    CGFloat firstPay = price * self.percent / 100;
    //利息  ((总价 - 首付) * 利率 * 期数)
    CGFloat rate = (allprice - firstPay) * 0.0067 * self.periods;
    //计息总价  (利息 + 总价)
    CGFloat ratePrice = rate + allprice;
    //月供   (计息总价 - 首付) / 期数
    CGFloat monthPay = (ratePrice - firstPay) / self.periods;
    
    //服务费   (裸车价 * 0.025)
    double servicePrice = price * 0.025;
    //保证金   (裸车价 * 0.1)
    double insurePrice = price * 0.1;
    //提车价  (首付 + 月供 + 保证金 + 服务费)
    double firstPrice = firstPay + monthPay + insurePrice + servicePrice;
    
    //首付(万元)
    self.firstPayLabel.text = [NSString stringWithFormat:@"%.2f万",firstPay / 10000];
    //月供（元)
    self.monthPayLabel.text = [NSString stringWithFormat:@"%.2f元",monthPay + 0.004];
    //提车前共支付（元）
    self.firstPayMoneyLabel.text = [NSString stringWithFormat:@"提车前共支付%.0f元",firstPrice];
    //提车费详情（元）
    self.firstDetailLabel.text = [NSString stringWithFormat:@"首付%.0f+首月租金%.0f+保证金%.0f+服务费%.0f",firstPay,monthPay,insurePrice,servicePrice];
}


-(void)btnClick{
    
    //立即预约
    [self.reserveBtn click:^(id value) {
        if ([self.detailDic[@"status"] isEqualToString:@"8"]) {
            return ;
        }
        
        if (!kUserLogin) {
             [ShowLoginManager showLoginVcFrom:self isTokenFailed:NO];
            return;
        }
        
        if ([self.detailDic[@"appointment"] boolValue]) {
            BFDMyReserveViewController *myReserveVC = [[BFDMyReserveViewController alloc] init];
            [self.navigationController pushViewController:myReserveVC animated:YES];
        }else{
            BFDReserveViewController *reserveVC = [[BFDReserveViewController alloc] init];
            reserveVC.good_id = self.goods_id;
            [self.navigationController pushViewController:reserveVC animated:YES];
        }
    }];
}

#pragma mark - 数据
-(void)getData{
    
    [BOCProgressHUD boc_ShowHUD];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.goods_id forKey:@"goods_id"];
    if (kUserLogin) {
        [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    }
    
    [JKHttpRequestService POST:@"/Home/Goods/simpleDetails" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [BOCProgressHUD boc_hiddenHUD];
        if (succe) {
            self.detailDic = jsonDic[@"data"];
            [self configureData:jsonDic[@"data"]];
        }
    } failure:^(void) {
        [BOCProgressHUD boc_hiddenHUD];
    } animated:NO];
}


@end
