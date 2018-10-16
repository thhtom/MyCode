//
//  AppUtil.m
//  LeChe
//
//  Created by yangxuran on 2018/3/21.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "AppUtil.h"
#import "SDImageCache.h"

@implementation AppUtil

/**
 *  获取app版本
 */
+ (NSString *)getAPPVersion {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    return infoDic[@"CFBundleShortVersionString"];
}

/*
 * 获取缓存大小
 */
+ (CGFloat)getCacheSize{
    NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
    
    NSString * myCachePath = [NSHomeDirectory() stringByAppendingString:@"Library/Caches"];
    
    NSDirectoryEnumerator * enumerator = [[NSFileManager defaultManager]enumeratorAtPath:myCachePath];
    
    __block  NSUInteger count = 0;
    
    for (NSString * fileName in enumerator) {
        NSString * path = [myCachePath stringByAppendingString:fileName];
        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        
        count += fileDict.fileSize;//自定义所有缓存大小
    }
    // 得到是字节  转化为M
    CGFloat totalSize = ((CGFloat)imageCacheSize+count)/1024/1024;
    return totalSize;
}

/*
 * 清除缓存
 */
+ (void)clearCache{
    //删除 sd 图片缓存
    //先清除内存中的图片缓存
    [[SDImageCache sharedImageCache] clearMemory];
    //清除磁盘的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    //2.删除自己缓存
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
    [[NSFileManager defaultManager]
     removeItemAtPath:myCachePath error:nil];
}

/*
 * 拨打电话
 */
+ (void)dial:(NSString *)tel {
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"telprompt:%@", tel]];
    
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        
    }];
}

@end
