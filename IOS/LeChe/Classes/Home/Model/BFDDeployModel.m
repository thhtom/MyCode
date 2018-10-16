//
//  BFDDeployModel.m
//  LeChe
//
//  Created by yangxuran on 2018/4/18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDDeployModel.h"
#import "BFDDeployDetailModel.h"

@implementation BFDDeployModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"group_list":[BFDDeployDetailModel class]};
}

@end
