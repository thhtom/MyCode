//
//  BFDSelectCarTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/3/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDMyCollectionModel;
@class CarModel;

@interface BFDSelectCarTableViewCell : UITableViewCell

@property (nonatomic, strong) BFDMyCollectionModel *collectionModel;
@property (nonatomic, strong) CarModel *carModel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
