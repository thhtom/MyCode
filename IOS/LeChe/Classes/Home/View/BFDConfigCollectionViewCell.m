//
//  BFDConfigCollectionViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/9/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDConfigCollectionViewCell.h"
#import "BFDConfigModel.h"

@interface BFDConfigCollectionViewCell()

@end

@implementation BFDConfigCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [QuickCreate createLabelWithFrame:CGRectMake(0, 0, self.width, self.height) text:@"全部" textColor:[UIColor whiteColor] fontSize:RSS(12) textAlignment:NSTextAlignmentCenter numberOfLines:1 isBold:NO];
    }
    return _titleLabel;
}

-(void)setModel:(BFDConfigModel *)model{
    _model = model;
    
    NSString *title = @"";
    if (model.isClass) {
        title = model.brand_name;
    }else if (model.isBrand){
        title = model.name;
    }else if (model.isPrice){
        title = model.price;
    }
    self.titleLabel.text = title;
    
    if (model.selected) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = RGBA(153, 153, 153, 1);
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
