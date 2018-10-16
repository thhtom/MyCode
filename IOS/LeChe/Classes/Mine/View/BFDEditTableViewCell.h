//
//  BFDEditTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/21.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFDEditTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
