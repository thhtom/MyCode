//
//  BFDMyOrderModel.m
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDMyOrderModel.h"

@implementation BFDMyOrderModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"des":@"description"};
}

@end
