//
//  DDebug.h
//  qtyd
//
//  Created by stephendsw on 15/9/28.
//  Copyright © 2015年 qtyd. All rights reserved.
//

#ifndef DDebug_h
  #define DDebug_h

  #ifdef DEBUG
    #define NSLog(...)      NSLog(__VA_ARGS__)
    #define debugMethod()   NSLog(@"%s", __func__)
  #else
    #define NSLog(...)
    #define debugMethod()
  #endif
#endif /* DDebug_h */

#define  TIME_INIT  __block double now = [NSDate date].timeIntervalSince1970 * 1000; __block double old;
#define  TIME_USE   old = now; now = [NSDate date].timeIntervalSince1970 * 1000; NSLog(@"运行用时:%f毫秒", now - old);
