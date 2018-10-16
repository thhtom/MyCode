//
//  BFDDetailOneTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/16.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDDetailFirstTableViewCell.h"
#import "BFDCarDeployModel.h"

static NSString *identifier = @"BFDDetailFirstTableViewCell";

@interface BFDDetailFirstTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation BFDDetailFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BFDDetailFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDDetailFirstTableViewCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

-(void)setModel:(BFDCarDeployModel *)model{
    _model = model;
    
    self.titleLabel.text = model.attr_name;
    self.valueLabel.text = model.attr_value;
}

@end
