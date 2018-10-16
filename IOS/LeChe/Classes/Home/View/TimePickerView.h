//
//  TimePickerView.h
//  HZ12315
//
//  Created by ZRAR on 14/12/9.
//  Copyright (c) 2014年 ZRAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimePickerView;
@protocol TimePickerViewDelegate <NSObject>

//- (void)timePickerView:(TimePickerView *)pickerView didSelectWithDateString:(NSString *)dateString;
@optional
- (void)getDate:(NSDate *)date;
@end

@interface TimePickerView : UIView

- (id)initWithDateFormatter:(NSDateFormatter *)formatter pickerMode:(UIDatePickerMode)pickerMode delegate:(id<TimePickerViewDelegate>)delegate;

- (void)showView;

@property (nonatomic, assign) BOOL disableMaximumDate;
/** 设置最小时间 */
@property (nonatomic, strong) NSDate *minDate;
/** 选择时间Block */
@property (nonatomic, copy) void (^dateStrBlock) (NSString *dateStr);

@end
