//
//  HomeCarTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/12.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "HomeCarTableViewCell.h"
#import "CarModel.h"

static NSString *const identifier = @"HomeCarTableViewCell";
static CGFloat const widthRatio = 270 / 750.0;

@interface HomeCarTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstPaylabel;
@property (weak, nonatomic) IBOutlet UILabel *monthPayLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@end

@implementation HomeCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (IPHONE5) {
        self.topMargin.constant = 20;
    }
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    HomeCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    }
    return cell;
}

-(void)setModel:(CarModel *)model{
    _model = model;
    
    NSString *str = [NSString stringWithFormat:@"%@%@",kBaseImgUrl,model.pic_url];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"car_placeholder"]];
    
    self.titleLabel.text = model.title;
    self.firstPaylabel.text = [NSString stringWithFormat:@"首付%@万",model.fir_apply];
    self.monthPayLabel.text = [NSString stringWithFormat:@"月供%@元",model.mon_apply];
    
    if ([model.status isEqualToString:@"8"]) {
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth * widthRatio, widthRatio * kUIScreenWidth / kAspectRatio)];
        coverView.backgroundColor = RGBA(0, 0, 0, 0.5);
        coverView.layer.cornerRadius = 4;
        [self.iconImageView addSubview:coverView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:coverView.bounds];
        label.text = @"即将上市";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [coverView addSubview:label];
    }
}

@end
