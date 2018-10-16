//
//  BFDBrandModel.h
//  LeChe
//
//  Created by yangxuran on 2018/9/25.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDBrandModel : NSObject

@property (nonatomic, copy) NSString *brand_id;
@property (nonatomic, copy) NSString *brand_logo;
@property (nonatomic, copy) NSString *brand_name;

@property (nonatomic, assign) BOOL isLast;

@end
