//
//  BFDDeployDetailTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/4/17.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDDeployDetailTableViewCell.h"
#import "BFDDeployDetailModel.h"

static NSString *const cellID = @"BFDDeployDetailTableViewCell";

@interface BFDDeployDetailTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation BFDDeployDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BFDDeployDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDDeployDetailTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGBColor(250, 250, 250);
    }
    return cell;
}

-(void)setModel:(BFDDeployDetailModel *)model{
    _model = model;
    
    self.nameLabel.text = model.attr_name;
    self.valueLabel.text = model.attr_value;
}

@end
