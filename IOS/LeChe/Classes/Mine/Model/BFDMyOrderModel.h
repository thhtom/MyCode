//
//  BFDMyOrderModel.h
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDMyOrderModel : NSObject

@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *order_id;
/** 订单编号 */
@property (nonatomic, copy) NSString *order_sn_id;
@property (nonatomic, copy) NSString *pay_time;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *price_sum;
@property (nonatomic, copy) NSString *mon_apply;
@property (nonatomic, copy) NSString *title;
/** 0代表下架  1代表上架 */
@property (nonatomic, copy) NSString *shelves;

/** 品牌logo */
@property (nonatomic, copy) NSString *brand_logo;
/** 品牌名称 */
@property (nonatomic, copy) NSString *brand_name;
/** 型号 */
@property (nonatomic, copy) NSString *des;

@end
