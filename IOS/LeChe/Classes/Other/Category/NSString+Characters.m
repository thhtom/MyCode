//
//  NSString+Characters.m
//  AddressBook
//
//  Created by Apple on 22/9/18.
//  Copyright © 2015年 HY. All rights reserved.
//


#import "NSString+Characters.h"

@implementation NSString (Characters)

//讲汉字转换为拼音
- (NSString *)pinyinOfName
{
    NSMutableString * name = [[NSMutableString alloc] initWithString:self];
    
    CFRange range = CFRangeMake(0, self.length);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    return [name.lowercaseString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//汉字转换为拼音后，返回大写的首字母
- (NSString *)uppercasePinYinFirstLetter
{
    NSMutableString * first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];
    CFRange range = CFRangeMake(0, 1);
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    return result.uppercaseString;
}
@end
