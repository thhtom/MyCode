//
//  HomeCarTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/12.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarModel;

@interface HomeCarTableViewCell : UITableViewCell

@property (nonatomic, strong) CarModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
