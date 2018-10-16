//
//  BFDMyorderTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDMyOrderModel;

@interface BFDMyorderTableViewCell : UITableViewCell

@property (nonatomic, strong) BFDMyOrderModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
