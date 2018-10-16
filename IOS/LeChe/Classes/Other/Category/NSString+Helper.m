//
//  NSString+Helper.m
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 分割字符串为数组
- (NSArray *)SeparateStringByCharacter:(NSString *)string
{
    NSArray *array=[self componentsSeparatedByString:string];
    
    return array;
}

#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    return ([self trimString].length == 0);
}

@end
