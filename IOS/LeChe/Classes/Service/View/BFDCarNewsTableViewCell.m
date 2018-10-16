//
//  BFDCarNewsTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/29.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDCarNewsTableViewCell.h"
#import "BFDCarNewsModel.h"

static NSString *const identifier = @"BFDCarNewsTableViewCell";

@interface BFDCarNewsTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end

@implementation BFDCarNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.shadowColor = kShadowColor.CGColor;
    self.bgView.layer.shadowOpacity = 0.1;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    BFDCarNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDCarNewsTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setModel:(BFDCarNewsModel *)model{
    _model = model;
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseImgUrl,model.pic_url]] placeholderImage:Img(@"banner_placeholder")];
    self.titleLabel.text = model.name;
    self.timeLabel.text = model.create_time;
    if (model.remark.length > 0) {
        self.remarkLabel.hidden = NO;
        self.remarkLabel.text = [NSString stringWithFormat:@"  # %@  ",model.remark];
        [self.remarkLabel sizeToFit];
    }else{
        self.remarkLabel.hidden = YES;
    }
}

@end
