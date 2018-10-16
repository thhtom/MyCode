//
//  BFDEditTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/21.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDEditTableViewCell.h"

static NSString *const identifier = @"BFDEditTableViewCell";

@interface BFDEditTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;


@end

@implementation BFDEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BFDEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDEditTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    self.titleLabel.text = dataDic[@"title"];
    self.contentLabel.text = dataDic[@"content"];
    if ([dataDic[@"status"] boolValue]) {
        self.detailBtn.hidden = YES;
    }else{
        self.detailBtn.hidden = NO;
    }
}

@end
