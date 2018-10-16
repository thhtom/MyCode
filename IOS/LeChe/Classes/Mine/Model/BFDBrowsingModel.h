//
//  BFDBrowsingModel.h
//  LeChe
//
//  Created by yangxuran on 2018/3/22.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDBrowsingModel : NSObject

@property (nonatomic, copy) NSString *gid;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_pic;
@property (nonatomic, copy) NSString *month_payment;
@property (nonatomic, copy) NSString *price_market;
@property (nonatomic, copy) NSString *price_member;
@property (nonatomic, copy) NSString *status;
/** 品牌logo */
@property (nonatomic, copy) NSString *brand_logo;
/** 品牌名称 */
@property (nonatomic, copy) NSString *brand_name;
/** 型号 */
@property (nonatomic, copy) NSString *des;
/** 0代表下架  1代表上架 */
@property (nonatomic, copy) NSString *shelves;
/** 图片是否朝右显示 （默认朝左）*/
@property (nonatomic, assign) BOOL isRight;

@end
