//
//  BFDMyReserveTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/22.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDMyReserveModel;

@interface BFDMyReserveTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^uploadPaperworkBlock) (void);
@property (nonatomic, copy) void (^cancelReserveBlock) (void);
@property (nonatomic, copy) void (^reReserveBlock) (void);
@property (nonatomic, copy) void (^seeReasonBlock) (void);
@property (nonatomic, copy) void (^delegeBlock) (void);
@property (nonatomic, copy) void (^seeOrderBlock) (void);

@property (nonatomic, strong) BFDMyReserveModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
