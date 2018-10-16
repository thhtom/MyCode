//
//  BFDMyorderTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDMyorderTableViewCell.h"
#import "BFDMyOrderModel.h"

static NSString *const identifier = @"BFDMyorderTableViewCell";

@interface BFDMyorderTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *orderImgView;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *branLabel;


@end

@implementation BFDMyorderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    BFDMyorderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDMyorderTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setModel:(BFDMyOrderModel *)model{
    _model = model;
    
    self.orderImgView.image = Img(@"mine_myorder");
    self.orderLabel.text = model.order_sn_id;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImgUrl,model.pic_url]] placeholderImage:Img(@"car_placeholder")];
    self.titleLabel.text = model.brand_name;
    self.timeLabel.text = model.pay_time;
    self.priceLabel.text = [NSString stringWithFormat:@"%@/月",model.mon_apply];
    self.branLabel.text = model.des;
}

@end
