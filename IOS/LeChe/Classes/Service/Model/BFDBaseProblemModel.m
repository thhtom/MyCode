//
//  BFDBaseProblemModel.m
//  LeChe
//
//  Created by yangxuran on 2018/5/7.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDBaseProblemModel.h"
#import "BFDProblemModel.h"

@implementation BFDBaseProblemModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [BFDProblemModel class]};
}

@end
