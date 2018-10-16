//
//  ServeCollectionViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/13.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "ServeCollectionViewCell.h"

@interface ServeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ServeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataDic:(NSDictionary *)dataDic{
    self.iconImageView.image = [UIImage imageNamed:dataDic[@"image"]];
    self.titleLabel.text = dataDic[@"title"];
}

@end
