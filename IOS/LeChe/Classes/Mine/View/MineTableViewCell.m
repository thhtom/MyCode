//
//  MineTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/13.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "MineTableViewCell.h"

static NSString *const identifier = @"MineTableViewCell";

@interface MineTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setDataDic:(NSDictionary *)dataDic{
    self.iconImageView.image = [UIImage imageNamed:dataDic[@"image"]];
    self.titleLabel.text = dataDic[@"title"];
}

@end
