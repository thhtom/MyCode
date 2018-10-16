//
//  BFDCarListTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarModel;

@interface BFDCarListTableViewCell : UITableViewCell

@property (nonatomic, strong) CarModel *model;
@property (weak, nonatomic) IBOutlet UIButton *reserveBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
