//
//  BFDOrderDetailViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDOrderDetailViewController.h"

@interface BFDOrderDetailViewController ()

@property (nonatomic, weak) UIScrollView *scrollerView;
@property (nonatomic, weak) UIView *detailView;
@property (nonatomic, strong) NSMutableArray *detailAry;

@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UILabel *firstTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;

@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLB;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (strong, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *phaseLB;
@property (weak, nonatomic) IBOutlet UILabel *monthPayLB;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@end

@implementation BFDOrderDetailViewController
-(NSMutableArray *)detailAry{
    if (!_detailAry) {
        _detailAry = [NSMutableArray array];
    }
    return _detailAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(245, 245, 245, 1);
    self.title = @"订单详情";
    
    [self createScrollerView];
    [self configureUI];
    
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"OrderDetailView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"OrderDetailView"];
}

-(void)configureUI{
    
    self.firstView.backgroundColor = [UIColor whiteColor];
    self.secondView.backgroundColor = [UIColor whiteColor];
    self.thirdView.backgroundColor = [UIColor whiteColor];
}


-(void)createScrollerView{
    
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - kNavigationBarHeight)];
    [self.view addSubview:scrollerView];
    self.scrollerView = scrollerView;

    self.firstView.frame = CGRectMake(0, 0, kUIScreenWidth, 146);
    [scrollerView addSubview:self.firstView];
    
    CGFloat imgH = (kUIScreenWidth - 100) / kAspectRatio;
    self.secondView.frame = CGRectMake(0, CGRectGetMaxY(self.firstView.frame), kUIScreenWidth, imgH + 173);
    [scrollerView addSubview:self.secondView];
    self.thirdView.frame = CGRectMake(0, CGRectGetMaxY(self.secondView.frame), kUIScreenWidth, 185);
    [scrollerView addSubview:self.thirdView];
    scrollerView.contentSize = CGSizeMake(kUIScreenWidth, CGRectGetMaxY(self.thirdView.frame) + 40);
}

-(void)configureData:(NSDictionary *)data{
    
    NSDictionary *detailDic = data[@"price"];
    
    self.nameLB.text = data[@"user_name"];
    self.phoneLB.text = data[@"mobile"];
    
    self.orderNumberLB.text = data[@"order_sn_id"];
    self.orderTimeLB.text = data[@"pay_time"];
    self.phoneLB.text = data[@"mobile"];
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImgUrl,data[@"pic_url"]]] placeholderImage:Img(@"car_placeholder")];
    self.titleLB.text = data[@"title"];
    
    self.priceLB.text = [NSString stringWithFormat:@"¥%@",detailDic[@"first_car_lift_cost"]];
    self.phaseLB.text = [NSString stringWithFormat:@"已还%@/%@期",data[@"paid_pmts"],data[@"tot_pmts"]];
    self.monthPayLB.text = [NSString stringWithFormat:@"¥%@",detailDic[@"monthly_mortgage_payment"]];
    
    NSArray *tempAry = @[detailDic[@"vehicle_shoufu"],detailDic[@"monthly_mortgage_payment"],detailDic[@"bond"],detailDic[@"service_fees"]];
    self.detailAry = [NSMutableArray arrayWithArray:tempAry];
}

#pragma mark - 提车费用详情按钮点击
- (IBAction)detailBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self createDetailView];
        self.topMargin.constant = 134;
        self.thirdView.height = 298;
        self.scrollerView.contentSize = CGSizeMake(kUIScreenWidth, CGRectGetMaxY(self.thirdView.frame) + 40);
    }else{
        [self.detailView removeFromSuperview];
        self.topMargin.constant = 17;
        self.thirdView.height = 185;
        self.scrollerView.contentSize = CGSizeMake(kUIScreenWidth, CGRectGetMaxY(self.thirdView.frame) + 40);
    }
}


#pragma mark - 提车费用详情
-(void)createDetailView{
    
    NSArray *titleAry = @[@"首付款",@"首月租金",@"保证金",@"服务费"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 103, kUIScreenWidth, 100)];
    [self.thirdView addSubview:view];
    self.detailView = view;
    
    CGFloat height = 14;
    CGFloat margin = height;
    for (int i = 0; i < 4; i ++) {
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (height + margin) * i, 100, height)];
        nameLabel.text = titleAry[i];
        nameLabel.textColor = RGBColor(153, 153, 153);
        nameLabel.font = Font(14);
        [view addSubview:nameLabel];
        
        UILabel *contentLabel =  [[UILabel alloc] initWithFrame:CGRectMake(kUIScreenWidth - 133, (height + margin) * i, 113, height)];
        contentLabel.text = [NSString stringWithFormat:@"¥%@",self.detailAry[i]];
        contentLabel.textColor = RGBColor(153, 153, 153);
        contentLabel.font = Font(14);
        contentLabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:contentLabel];
    }
}

#pragma mark - 数据
-(void)getData{
    
    [BOCProgressHUD boc_ShowHUD];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[AccountTool sharedAccountTool].account.user_id forKey:@"user_id"];
    [params setObject:self.order_id forKey:@"order_id"];
    
    [JKHttpRequestService POST:@"/Home/Orders/ordersDetails" withParameters:params success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        [BOCProgressHUD boc_hiddenHUD];
        if (succe) {
            [self configureData:jsonDic[@"data"]];
        }
    } failure:^(void) {
        [BOCProgressHUD boc_hiddenHUD];
    } animated:NO];
}


@end
