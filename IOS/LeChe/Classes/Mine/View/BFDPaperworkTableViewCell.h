//
//  BFDPaperworkTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/4/13.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFDPaperworkTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^reuploadBlock) (BFDPaperworkTableViewCell *cell);
@property (nonatomic, strong) NSDictionary *originalDic;
@property (nonatomic, copy) NSString *imageStr;
@property (nonatomic, assign) BOOL isReviewing; //是否审核中
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
