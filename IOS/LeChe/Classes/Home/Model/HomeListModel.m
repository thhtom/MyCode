//
//  HomeListModel.m
//  LeChe
//
//  Created by yangxuran on 2018/3/9.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "HomeListModel.h"
#import "CarModel.h"

@implementation HomeListModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"car_list" : [CarModel class]};
}

@end
