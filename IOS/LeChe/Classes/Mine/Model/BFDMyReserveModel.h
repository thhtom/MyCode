//
//  BFDMyReserveModel.h
//  LeChe
//
//  Created by yangxuran on 2018/3/22.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDMyReserveModel : NSObject

/** 添加时间 */
@property (nonatomic, copy) NSString *addtime;
/** 状态 */
@property (nonatomic, copy) NSString *status;//状态(0:预约中,1:邀请中,2:已完成,3:已取消,4:已驳回)
/** 图片url */
@property (nonatomic, copy) NSString *pic_url;
/** title */
@property (nonatomic, copy) NSString *title;
/** 城市名称 */
@property (nonatomic, copy) NSString *c_name;
/** 预约单号 */
@property (nonatomic, copy) NSString *reservation_number;
/** 预约手机号 */
@property (nonatomic, copy) NSString *reservations_phone;
/** 预约姓名 */
@property (nonatomic, copy) NSString *reservations_name;
/** 门店名称 */
@property (nonatomic, copy) NSString *shopname;
/** 门店ID */
@property (nonatomic, copy) NSString *address_id;
/** 车ID */
@property (nonatomic, copy) NSString *goods_id;
/** 车的组ID */
@property (nonatomic, copy) NSString *goods_class_id;
/** 预约时间 */
@property (nonatomic, copy) NSString *ctime;
/** 0代表下架  1代表上架 */
@property (nonatomic, copy) NSString *shelves;
/** 驳回信息 */
@property (nonatomic, copy) NSString *reject_explain;


/** 品牌logo */
@property (nonatomic, copy) NSString *brand_logo;
/** 品牌名称 */
@property (nonatomic, copy) NSString *brand_name;
/** 车型 */
@property (nonatomic, copy) NSString *des;

@end
