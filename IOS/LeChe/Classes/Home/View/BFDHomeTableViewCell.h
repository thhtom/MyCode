//
//  BFDHomeTableViewCell.h
//  LeChe
//
//  Created by yangxuran on 2018/9/18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarModel;
@class BFDBrowsingModel;
@class BFDMyCollectionModel;

@interface BFDHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) CarModel *model;
@property (nonatomic, strong) BFDBrowsingModel *browsModel;
@property (nonatomic, strong) BFDMyCollectionModel *collectionModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
