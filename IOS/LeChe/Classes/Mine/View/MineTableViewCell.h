//
//  MineTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/13.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
