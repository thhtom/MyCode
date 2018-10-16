//
//  BFDMyCollectionModel.m
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDMyCollectionModel.h"

@implementation BFDMyCollectionModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"carID":@"id", @"des":@"description"};
}

@end
