//
//  BFDConfigCollectionViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/9/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDConfigModel;

@interface BFDConfigCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BFDConfigModel *model;
@property (nonatomic, strong) UILabel *titleLabel;

@end
