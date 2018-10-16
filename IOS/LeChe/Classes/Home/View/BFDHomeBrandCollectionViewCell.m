//
//  BFDHomeBrandCollectionViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/9/18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDHomeBrandCollectionViewCell.h"
#import "BFDBrandModel.h"

@interface BFDHomeBrandCollectionViewCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BFDHomeBrandCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(void)setModel:(BFDBrandModel *)model{
    _model = model;

    if (model.isLast) {
        self.imgView.image = Img(model.brand_logo);
    }else{
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.brand_logo] placeholderImage:Img(@"brand_placeholder")];
    }
    self.titleLabel.text = model.brand_name;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(RSS(16), RSS(14), RSS(44), RSS(44))];
    }
    return _imgView;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QuickCreate createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgView.frame) + RSS(8), self.width, RSS(11)) text:@"阿斯顿·马丁" textColor:RGBA(153, 153, 153, 1) fontSize:RSS(12) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
    }
    return _titleLabel;
}

@end
