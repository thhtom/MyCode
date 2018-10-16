//
//  BFDCommonProblemTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/5/7.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDProblemModel;

@interface BFDCommonProblemTableViewCell : UITableViewCell

@property (nonatomic, strong) BFDProblemModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
