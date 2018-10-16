//
//  Account.h
//
//  Created by Remmo on 16/10/11.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *user_header;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *token;
/** 0：未认证， 1:待审核， 2：审核失败， 3：审核成功 */
@property (nonatomic, copy) NSString *is_authentication;

@end
