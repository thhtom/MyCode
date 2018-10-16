//
//  BFDHomeTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/9/18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDHomeTableViewCell.h"
#import "CarModel.h"
#import "BFDBrowsingModel.h"
#import "BFDMyCollectionModel.h"

@interface BFDHomeTableViewCell()

@property (nonatomic, weak) UIImageView *bgImgView;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *brandLabel;
@property (nonatomic, weak) UIView *brandBgView;
@property (nonatomic, weak) UIView *brandView;
@property (nonatomic, weak) UIView *coverView;

@end

@implementation BFDHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)createUI{
    
    //背景图
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, RSS(250))];
    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:bgImgView];
    self.bgImgView = bgImgView;
    
    //朝右显示的颜色
    UIView *coverView = [[UIView alloc] initWithFrame:bgImgView.bounds];
    [bgImgView addSubview:coverView];
    self.coverView = coverView;
    
    //品牌 型号
    UIView *brandBgView = [[UIView alloc] initWithFrame:CGRectMake(RSS(15), RSS(29), kUIScreenWidth, RSS(25))];
    [self.contentView addSubview:brandBgView];
    self.brandBgView = brandBgView;
    
    //小图标
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RSS(24), RSS(24))];
    [brandBgView addSubview:imgView];
    self.imgView = imgView;
    
    UIView *brandView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + RSS(4), 0, RSS(100), RSS(25))];
    [brandBgView addSubview:brandView];
    self.brandView = brandView;
    
     UILabel *titleLabel = [QuickCreate createLabelWithFrame:CGRectMake(0, 0, RSS(150), RSS(9)) text:@"S-CLASS SEDAN" textColor:RGBA(102, 102, 102, 1) fontSize:RSS(12) textAlignment:NSTextAlignmentLeft numberOfLines:1 isBold:NO];
    [brandView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *brandLabel = [QuickCreate createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + RSS(5), kUIScreenWidth, RSS(11)) text:@"GLE 320 4MATIC" textColor:RGBA(51, 51, 51, 1) fontSize:RSS(14) textAlignment:NSTextAlignmentLeft numberOfLines:1 isBold:NO];
    [brandView addSubview:brandLabel];
    self.brandLabel = brandLabel;
    
    //总价 首付 月供
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, RSS(204), kUIScreenWidth, RSS(35))];
    view.backgroundColor = [UIColor clearColor];
    NSInteger count = 3;
    CGFloat W = kUIScreenWidth / count;
    NSArray *titileAry = @[@"总价",@"首付",@"月供"];
    for (int i = 0; i < count; i ++) {
        UILabel *label = [QuickCreate createLabelWithFrame:CGRectMake(i * W, 0, W, RSS(12)) text:titileAry[i] textColor:RGBA(153, 153, 153, 1) fontSize:RSS(12) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
        [view addSubview:label];
        
        UILabel *value = [QuickCreate createLabelWithFrame:CGRectMake(i * W, CGRectGetMaxY(label.frame) + RSS(10), W, RSS(12)) text:titileAry[i] textColor:RGBA(51, 51, 51, 1) fontSize:RSS(14) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
        value.tag = i + 100;
        [view addSubview:value];
        if (i != count - 1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, 0.5, RSS(15))];
            lineView.backgroundColor = RGBA(153, 153, 153, 1);
            lineView.centerY = view.height / 2;
            [view addSubview:lineView];
        }
    }
    
    [self.contentView addSubview:view];
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, RSS(249), kUIScreenWidth, RSS(1))];
    lineView.backgroundColor = RGBA(235, 235, 235, 1);
    [self.contentView addSubview:lineView];
}

-(void)setModel:(CarModel *)model{
    _model = model;
    
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:Img(@"car_placeholder")];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.brand_logo] placeholderImage:Img(@"brand_placeholder")];
    self.titleLabel.text = model.brand_name;
    self.brandLabel.text = model.des;
    
    UILabel *allMoney = (UILabel *)[self viewWithTag:100];
    double money = [model.price_market doubleValue] * 10000;
    allMoney.text = [[NSString stringWithFormat:@"%.0f",money] moneyFormatShowWithInt];
    
    UILabel *firstPay = (UILabel *)[self viewWithTag:101];
    double first = [model.fir_apply doubleValue] * 10000;
    firstPay.text = [[NSString stringWithFormat:@"%.2f",first] moneyFormatShow];
    
    UILabel *monthPay = (UILabel *)[self viewWithTag:102];
    monthPay.text = [model.mon_apply moneyFormatShow];
    
    //改变图片方向
    [self updateUI:model.isRight];
}

-(void)setBrowsModel:(BFDBrowsingModel *)browsModel{
    _browsModel = browsModel;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kBaseImgUrl,browsModel.goods_pic];
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:Img(@"car_placeholder")];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:browsModel.brand_logo] placeholderImage:Img(@"brand_placeholder")];
    
    self.titleLabel.text = browsModel.brand_name;
    
    self.brandLabel.text = browsModel.des;
    
    UILabel *allMoneyLabel = (UILabel *) [self viewWithTag:100];
    double money = [browsModel.price_market doubleValue] * 10000;
    allMoneyLabel.text = [[NSString stringWithFormat:@"%.0f",money] moneyFormatShowWithInt];
    
    UILabel *firstPayLabel = (UILabel *) [self viewWithTag:101];
    firstPayLabel.text = [browsModel.price_member moneyFormatShow];
    
    UILabel *monthPayLabel = (UILabel *) [self viewWithTag:102];
    monthPayLabel.text = [browsModel.month_payment moneyFormatShow];
    
    //改变图片方向
    [self updateUI:browsModel.isRight];
}

-(void)setCollectionModel:(BFDMyCollectionModel *)collectionModel{
    _collectionModel = collectionModel;
    
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImgUrl,collectionModel.img]] placeholderImage:Img(@"car_placeholder")];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:collectionModel.brand_logo] placeholderImage:Img(@"brand_placeholder")];
    self.titleLabel.text = collectionModel.brand_name;
    self.brandLabel.text = collectionModel.des;
    
    UILabel *allMoney = (UILabel *)[self viewWithTag:100];
    allMoney.text = [collectionModel.price_member moneyFormatShowWithInt];
    
    UILabel *firstPay = (UILabel *)[self viewWithTag:101];
    double first = [collectionModel.price_member doubleValue] * [collectionModel.fir_apply_rate doubleValue];
    firstPay.text = [[NSString stringWithFormat:@"%.2f",first] moneyFormatShow];
    
    UILabel *monthPay = (UILabel *)[self viewWithTag:102];
    monthPay.text = [collectionModel.mon_apply moneyFormatShow];
    
    //改变图片方向
    [self updateUI:collectionModel.isRight];
}

-(void)updateUI:(BOOL)isRight{
    
    CGFloat titleW = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:RSS(12)]].width;
    CGFloat brandW = [self.brandLabel.text sizeWithFont:[UIFont systemFontOfSize:RSS(14)]].width;
    self.brandView.width = MAX(titleW, brandW);
    CGFloat bgBrandW = self.imgView.width + RSS(4) + self.brandView.width;
    self.brandBgView.width = bgBrandW;
    
    if (isRight) {
        //图片翻转
        self.bgImgView.transform = CGAffineTransformMakeScale(-1, 1);
        self.brandBgView.frame = CGRectMake(kUIScreenWidth - RSS(15) - bgBrandW, RSS(25), bgBrandW, RSS(25));
        self.coverView.backgroundColor = RGBA(0, 0, 0, 0.1);
    }else{
        //图片翻转
        self.bgImgView.transform = CGAffineTransformMakeScale(1, 1);
        self.brandBgView.frame = CGRectMake(RSS(15), RSS(25), bgBrandW, RSS(25));
        self.coverView.backgroundColor = RGBA(0, 0, 0, 0);
    }
}

@end
