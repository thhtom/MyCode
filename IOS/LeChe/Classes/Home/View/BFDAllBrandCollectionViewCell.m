//
//  BFDAllBrandCollectionViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/9/18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDAllBrandCollectionViewCell.h"
#import "BFDConfigModel.h"

@interface BFDAllBrandCollectionViewCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BFDAllBrandCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(void)setModel:(BFDConfigModel *)model{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.brand_logo] placeholderImage:Img(@"brand_placeholder")];
    self.titleLabel.text = model.brand_name;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(RSS(17), RSS(12), RSS(60), RSS(60))];
        _imgView.backgroundColor = [UIColor whiteColor];
    }
    return _imgView;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QuickCreate createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame) + RSS(2), self.width, RSS(11)) text:@"" textColor:RGBA(153, 153, 153, 1) fontSize:RSS(12) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
    }
    return _titleLabel;
}

@end
