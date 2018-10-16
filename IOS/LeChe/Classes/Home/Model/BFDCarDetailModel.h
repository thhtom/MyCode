//
//  BFDCarDetailModel.h
//  LeChe
//
//  Created by yangxuran on 2018/3/16.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDCarDetailModel : NSObject

@property (nonatomic, copy) NSString *fir_apply;
@property (nonatomic, copy) NSString *mon_apply;

/** 裸车价 万 */
@property (nonatomic, copy) NSString *price_market;
/** 总价 元 */
@property (nonatomic, copy) NSString *car_total_price;
/** 首付比例 */
@property (nonatomic, copy) NSString *fir_apply_rate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *carID;
@property (nonatomic, copy) NSString *total;
/** 5-新品  6-爆款  7-免手付 8-即将上市*/
@property (nonatomic, copy) NSString *status;
/** 裸车价（元） */
@property (nonatomic, copy) NSString *bare_car;

@end
