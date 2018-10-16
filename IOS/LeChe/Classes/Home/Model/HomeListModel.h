//
//  HomeListModel.h
//  LeChe
//
//  Created by yangxuran on 2018/3/9.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CarModel;

@interface HomeListModel : NSObject

@property (nonatomic, copy) NSString *class_id;
@property (nonatomic, copy) NSString *class_name;
@property (nonatomic, strong) NSArray *car_list;
@property (nonatomic, strong) CarModel *carModel;

@end
