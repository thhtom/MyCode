//
//  BFDSelectCarTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDSelectCarTableViewCell.h"
#import "BFDMyCollectionModel.h"
#import "CarModel.h"

static CGFloat const widthRatio = 270 / 750.0;

static NSString *const identifier = @"BFDSelectCarTableViewCell";

@interface BFDSelectCarTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation BFDSelectCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    BFDSelectCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDSelectCarTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setCollectionModel:(BFDMyCollectionModel *)collectionModel{
    _collectionModel = collectionModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImgUrl,collectionModel.img]] placeholderImage:Img(@"banner_placeholder")];
    self.titleLabel.text = collectionModel.title;
    
    if ([collectionModel.status isEqualToString:@"8"]) {
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

-(void)setCarModel:(CarModel *)carModel{
    _carModel = carModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImgUrl,carModel.pic_url]] placeholderImage:Img(@"banner_placeholder")];
    self.titleLabel.text = carModel.title;
    
    if ([carModel.status isEqualToString:@"8"]) {
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
