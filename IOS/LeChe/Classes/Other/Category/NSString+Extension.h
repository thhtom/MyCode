//
//  NSString+Extension.h
//  LeChe
//
//  Created by yangxuran on 18-3-18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/*
 * 计算文字size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

/*
 * 验证手机号是否合法
 */
- (BOOL)valiMobile;

/*
 * 手机号隐藏中间四位
 */
- (NSString *)phoneFormat;

/*
 * 格式化金额(xxx,xxx,xx),用于显示数据
 */
- (NSString *)moneyFormatShow;

- (NSString *)moneyFormatShowWithInt;

@end
