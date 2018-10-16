//
//  AppUtil.h
//  LeChe
//
//  Created by yangxuran on 2018/3/21.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtil : NSObject

/**
 *  获取app版本
 */
+ (NSString *)getAPPVersion;

/*
 * 获取缓存大小
 */
+ (CGFloat)getCacheSize;

/*
 * 清除缓存
 */
+ (void)clearCache;

/*
 * 拨打电话
 */
+ (void)dial:(NSString *)tel;

@end
