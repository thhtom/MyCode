//
//  AccountTool.h
//
//  Created by Remmo on 16/10/11.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "Singleton.h"

@interface AccountTool : NSObject

single_interface(AccountTool)

- (void)saveAccount:(Account *)account;
- (void)removeAccount;

// 获得当前账号
@property (nonatomic, readonly) Account *account;

@end
