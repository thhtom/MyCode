//
//  BFDCarNewsTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/29.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDCarNewsModel;

@interface BFDCarNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) BFDCarNewsModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
