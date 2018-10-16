//
//  CarModel.m
//  LeChe
//
//  Created by yangxuran on 2018/3/9.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"carID": @"id", @"des": @"description"};
}

@end
