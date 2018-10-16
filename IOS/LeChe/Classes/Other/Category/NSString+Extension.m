//
//  NSString+Extension.m
//  LeChe
//
//  Created by yangxuran on 18-3-18.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

/*
 * 验证手机号是否合法
 */
- (BOOL)valiMobile{
    NSString *phoneStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phoneStr.length != 11)
    {
        return NO;
    }else{
        
        /*
         * 手机正则表达式
         */
        NSString *num = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
        BOOL isMatch = [pred evaluateWithObject:phoneStr];
        if (isMatch) {
            return YES;
        }else{
            return NO;
        }
    }
}

/*
 * 手机号隐藏中间四位
 */
- (NSString *)phoneFormat {
    NSString *temp = self;
    
    if (temp.length == 11) {
        temp = [temp stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    return temp;
}

/*
 * 格式化金额(xxx,xxx,xx),用于显示数据
 */
- (NSString *)moneyFormatShow {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    
    [currencyFormatter setPositiveFormat:@"###,##0.00;"];
    return [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
}

- (NSString *)moneyFormatShowWithInt{
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    
    [currencyFormatter setPositiveFormat:@"###,##0;"];
    return [currencyFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
}

@end
