//
//  BFDDeatilHeaderView.m
//  LeChe
//
//  Created by yangxuran on 2018/3/15.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDDeatilHeaderView.h"
#import "SDCycleScrollView.h"
#import "JYCarousel.h"
#import "BFDCarDetailModel.h"
#import "XRSlider.h"

static CGFloat const aspectRatio = 16 / 9.0;

@interface BFDDeatilHeaderView()<JYCarouselDelegate>

@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPayMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPayDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthPayLabel;

@property (weak, nonatomic) IBOutlet UIView *firstPayScaleView;
@property (weak, nonatomic) IBOutlet UIView *monthPayScaleView;

@property (nonatomic, weak) JYCarousel *carouseView;

@property (nonatomic, strong) NSArray *firstAry;
@property (nonatomic, strong) NSArray *monthAry;
@property (nonatomic, assign) int percent; //首付百分比
@property (nonatomic, assign) int periods; //期数

@property (nonatomic, weak) XRSlider *firstSlider;
@property (nonatomic, weak) XRSlider *monthSlider;

@end

@implementation BFDDeatilHeaderView

+(instancetype)createHeaderView{
    return [[NSBundle mainBundle] loadNibNamed:@"BFDDeatilHeaderView" owner:nil options:nil].firstObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];

    JYCarousel *carouseView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenWidth / aspectRatio) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
        carouselConfig.pageContollType = MiddlePageControl;
        carouselConfig.contentMode = UIViewContentModeScaleAspectFill;
        carouselConfig.pageTintColor = RGBA(202, 202, 202, 1);
        carouselConfig.currentPageTintColor = RGBA(51, 51, 51, 1);
        carouselConfig.placeholder = [UIImage imageNamed:@"banner_placeholder"];
        carouselConfig.faileReloadTimes = 5;
        carouselConfig.textAlignment = NSTextAlignmentLeft;
        return carouselConfig;
    } target:self];
    self.carouseView = carouseView;
    [self.bannerView addSubview:carouseView];
    
    self.firstAry = @[@"20%",@"30%",@"40%",@"50%"];
    self.monthAry = @[@"12期",@"18期",@"24期",@"30期",@"36期",@"42期",@"48期"];
    
    [self createSlider];
}

-(void)createSlider{
    
    self.firstPayScaleView.width = kUIScreenWidth;
    self.monthPayScaleView.width = kUIScreenWidth;
    
    if (IPHONE5) {
        self.firstPayDetailLabel.font = [UIFont systemFontOfSize:10];
    }else{
        self.firstPayDetailLabel.font = [UIFont systemFontOfSize:12];
    }
    
    XRSlider *firstSlider = [[XRSlider alloc] initWithFrame:CGRectMake(0, 0, self.firstPayScaleView.width, self.firstPayScaleView.height) titleAry:self.firstAry];
    firstSlider.valueChangeBlock = ^(NSInteger index) {
        //选择的首付百分比
        NSString *str = self.firstAry[index];
        self.percent = [[str substringToIndex:str.length - 1] intValue];
        
        [self configData];
    };
    self.firstSlider = firstSlider;
    [self.firstPayScaleView addSubview:firstSlider];
    
    XRSlider *monthSlider = [[XRSlider alloc] initWithFrame:CGRectMake(0, 0, self.monthPayScaleView.width, self.monthPayScaleView.height) titleAry:self.monthAry];
    monthSlider.valueChangeBlock = ^(NSInteger index) {
        //选择的期数
        NSString *str = self.monthAry[index];
        self.periods = [[str substringToIndex:str.length - 1] intValue];
        
        [self configData];
    };
    self.monthSlider = monthSlider;
    [self.monthPayScaleView addSubview:monthSlider];
}

-(void)setModel:(BFDCarDetailModel *)model{
    _model = model;
    
    NSInteger index = ([model.fir_apply_rate integerValue] - 20) / 10;
    if (index >= self.firstAry.count || index < 0) {
        index = 0;
    }
    
    [self.firstSlider setSelectIndex:index];
    [self.monthSlider setSelectIndex:([model.total intValue] - 12) / 6];

    self.titleLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"%@万",model.price_market];
    
    switch ([model.status integerValue]) {
        case 5:{//新品
            self.statusImgView.image = Img(@"status_xinpin");
        }
            break;
        case 6:{//爆款
            self.statusImgView.image = Img(@"home_detail_baokuan");
        }
            break;
        case 7:{//免手付
            self.statusImgView.image = Img(@"status_mianshoufu");
        }
            break;
            
        default:
            self.statusImgView.image = nil;
            break;
    }
    [self.bannerView bringSubviewToFront:self.statusImgView];
}

-(void)setImageAry:(NSMutableArray *)imageAry{
    [self.carouseView startCarouselWithArray:imageAry];
}

-(void)configData{
    
    //裸车价
    double price = [_model.price_market doubleValue] * 10000;
    
    //总价
    double allprice = [_model.car_total_price doubleValue];
    
    //首付   (裸车价 * 首付比例)
    double firstPay = price * self.percent / 100;
    
    //利息  ((总价 - 首付)  * 利率 * 期数)
    double rate = (allprice - firstPay) * 0.0067 * self.periods;
    
    //计息总价  (利息 + 总价)
    double ratePrice = rate + allprice;
    
    //服务费   (裸车价 * 0.025)
    double servicePrice = price * 0.025;
    
    //保证金   (裸车价 * 0.1)
    double insurePrice = price * 0.1;
    
    //月供   (计息总价 - 首付) / 期数
    double monthPay = (ratePrice - firstPay) / self.periods;
    
    //提车价  (首付 + 月供 + 保证金 + 服务费)
    double firstPrice = firstPay + monthPay + insurePrice + servicePrice;
    
    
    //首付
    self.firstPayLabel.text = [NSString stringWithFormat:@"%.2f万",firstPay / 10000];
    
    //月供
    self.monthPayLabel.text = [NSString stringWithFormat:@"%.2f元",monthPay + 0.004];
    
    //第一次需支付总额
    self.firstPayMoneyLabel.text = [NSString stringWithFormat:@"提车前共需支付%.0f元",firstPrice];
    
    //第一次需支付总额详情
    self.firstPayDetailLabel.text = [NSString stringWithFormat:@"首付%.0f+首月租金%.0f+保证金%.0f+服务费%.0f",firstPay,monthPay,insurePrice,servicePrice];
}

#pragma mark  月供计算公式
- (void)calculationFormula:(float)value{
    self.firstPayLabel.text = [NSString stringWithFormat:@"%0.2f万",[_model.price_market floatValue]*value];
    self.monthPayLabel.text = [NSString stringWithFormat:@"%0.2f元",[_model.price_market floatValue]*(1-value)/[_model.total intValue]*10000];
}


@end
