//
//  CarModel.h
//  LeChe
//
//  Created by yangxuran on 2018/3/9.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject

@property (nonatomic, copy) NSString *carID;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *fir_apply;
@property (nonatomic, copy) NSString *mon_apply;
@property (nonatomic, copy) NSString *price_market;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *brand_logo;
@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, copy) NSString *des;

@property (nonatomic, assign) BOOL isRight; //YES 朝右（默认朝左）

@end
