//
//  AccountTool.m
//
//  Created by Remmo on 16/10/11.
//  Copyright © 2016年 xxx. All rights reserved.
//

#import "AccountTool.h"

// 文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation AccountTool

single_implementation(AccountTool)

- (instancetype)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

- (void)saveAccount:(Account *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}

- (void)removeAccount
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:kFile]) {
        [[NSFileManager defaultManager] removeItemAtPath:kFile error:nil];
    }
}


@end
