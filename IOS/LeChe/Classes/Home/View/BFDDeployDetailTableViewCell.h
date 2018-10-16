//
//  BFDDeployDetailTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/4/17.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDDeployDetailModel;

@interface BFDDeployDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) BFDDeployDetailModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
