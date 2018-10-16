//
//  BFDDeatilHeaderView.h
//  LeChe
//
//  Created by yangxuran on 2018/3/15.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDCarDetailModel;

@interface BFDDeatilHeaderView : UIView

@property (nonatomic, strong) BFDCarDetailModel *model;
@property (nonatomic, strong) NSMutableArray *imageAry;

+(instancetype)createHeaderView;

@end
