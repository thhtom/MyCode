//
//  BFDCarListTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDCarListTableViewCell.h"
#import "CarModel.h"

static NSString *const identifier = @"BFDCarListTableViewCell";

@interface BFDCarListTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pirceLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthPayLabel;


@end

@implementation BFDCarListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 5;
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.shadowColor = kShadowColor.CGColor;
    self.bgView.layer.shadowOpacity = 0.15;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BFDCarListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDCarListTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setModel:(CarModel *)model{
    _model = model;
    NSString *imgStr = [NSString stringWithFormat:@"%@%@",kBaseImgUrl,model.pic_url];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:Img(@"banner_placeholder")];
    self.titleLabel.text = model.title;
    self.pirceLabel.text = [NSString stringWithFormat:@"官方指导价%@万",model.price_market];
    self.firstPayLabel.text = [NSString stringWithFormat:@"首付%@万",model.fir_apply];
    self.monthPayLabel.text = [NSString stringWithFormat:@"月供%@元",model.mon_apply];
    
    if ([model.status isEqualToString:@"8"]) {
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth - 100, (kUIScreenWidth - 100) / kAspectRatio)];
        coverView.backgroundColor = RGBA(0, 0, 0, 0.5);
        coverView.layer.cornerRadius = 4;
        [self.iconImageView addSubview:coverView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:coverView.bounds];
        label.text = @"即将上市";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [coverView addSubview:label];
        
        [self.reserveBtn setTitle:@"即将上市" forState:UIControlStateNormal];
    }
}

@end
