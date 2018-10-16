//
//  BFDSecondTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/16.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDBrightModel;

@interface BFDDetailSecondTableViewCell : UITableViewCell

@property (nonatomic, strong) BFDBrightModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
