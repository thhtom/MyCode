//
//  AppDelegate+Analysis.m
//  LeChe
//
//  Created by yangxuran on 2018/4/25.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "AppDelegate+Analysis.h"

@implementation AppDelegate (Analysis)

- (void)umengAnalysis{
    
    [UMConfigure setEncryptEnabled:YES];
    [UMConfigure setLogEnabled:NO];
    [UMConfigure initWithAppkey:@"5adfe58ef29d985662000172" channel:@"APP Store"];
}

@end
