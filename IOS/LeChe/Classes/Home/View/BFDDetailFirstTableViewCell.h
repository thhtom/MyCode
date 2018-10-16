//
//  BFDDetailOneTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/16.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDCarDeployModel;

@interface BFDDetailFirstTableViewCell : UITableViewCell

@property(nonatomic, strong) BFDCarDeployModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
