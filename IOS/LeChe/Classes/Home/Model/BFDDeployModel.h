//
//  BFDDeployModel.h
//  LeChe
//
//  Created by yangxuran on 2018/4/18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFDDeployDetailModel;

@interface BFDDeployModel : NSObject

@property (nonatomic, copy) NSString *group_name;
@property (nonatomic, strong) NSArray *group_list;
@property (nonatomic, strong) BFDDeployDetailModel *model;
@property (nonatomic, assign) BOOL isHidden;

@end
