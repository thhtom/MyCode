//
//  BFDMyCollectionModel.h
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDMyCollectionModel : NSObject

@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *carID;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *p_id;
@property (nonatomic, copy) NSString *price_member;
@property (nonatomic, copy) NSString *fir_apply_rate;
@property (nonatomic, copy) NSString *mon_apply;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *brand_logo; //品牌logo
@property (nonatomic, copy) NSString *brand_name; //品牌
@property (nonatomic, copy) NSString *des; //型号
@property (nonatomic, copy) NSString *shelves; //0代表下架  1代表上架

/** 图片是否朝右显示 （默认朝左）*/
@property (nonatomic, assign) BOOL isRight;

@end
