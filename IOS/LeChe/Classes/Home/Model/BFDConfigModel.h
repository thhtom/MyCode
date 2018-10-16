//
//  BFDConfigModel.h
//  LeChe
//
//  Created by yangxuran on 2018/9/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDConfigModel : NSObject

@property (nonatomic, assign) BOOL isBrand;
@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, copy) NSString *brand_logo;

@property (nonatomic, assign) BOOL isPrice;
@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) BOOL isClass;
@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL selected;

@end
