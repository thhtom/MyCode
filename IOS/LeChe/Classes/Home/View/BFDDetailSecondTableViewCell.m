//
//  BFDSecondTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/16.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDDetailSecondTableViewCell.h"
#import "BFDBrightModel.h"

static NSString *const identifier = @"BFDDetailSecondTableViewCell";

@interface BFDDetailSecondTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BFDDetailSecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BFDDetailSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDDetailSecondTableViewCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

-(void)setModel:(BFDBrightModel *)model{
    _model = model;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:Img(@"car_placeholder")];
    self.titleLabel.text = model.word;
}

@end
