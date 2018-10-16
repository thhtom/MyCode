//
//  NSString+Timeline.m
//

#import "NSString+Timeline.h"

@implementation NSString (Timeline)

- (NSString *)timelineToDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    return [dateFormatter stringFromDate:date];
}

@end
