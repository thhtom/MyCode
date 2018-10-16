//
//  BFDReserveViewController.h
//  LeChe
//
//  Created by yangxuran on 2018/3/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDMyReserveModel;

@interface BFDReserveViewController : UIViewController

@property (nonatomic, copy) NSString *good_id;
@property (nonatomic, strong) BFDMyReserveModel *model;

@end
