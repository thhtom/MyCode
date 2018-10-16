//
//  TimePickerView.m
//  HZ12315
//
//  Created by ZRAR on 14/12/9.
//  Copyright (c) 2014年 ZRAR. All rights reserved.
//

#import "TimePickerView.h"

#define kDatePickerBackViewHeight 256
#define kDatePickerHeight 216
#define kAnimationDuration 0.25

#define kButtonWidth 60
#define kButtonHeight kDatePickerBackViewHeight - kDatePickerHeight

@interface TimePickerView ()

@property (nonatomic, assign) id<TimePickerViewDelegate> delegate;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, weak) UIView *pickBackView;
@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UIDatePicker *pickView;

@property (nonatomic, assign)UIDatePickerMode pickerMode;

@end

@implementation TimePickerView

- (id)initWithDateFormatter:(NSDateFormatter *)formatter pickerMode:(UIDatePickerMode)pickerMode delegate:(id<TimePickerViewDelegate>)delegate
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight);
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5f];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *cancelGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelBtnClicked)];
        [self addGestureRecognizer:cancelGesture];
        
        if (delegate) {
            self.delegate = delegate;
        }
        if (formatter) {
            self.formatter = formatter;
        }
        self.pickerMode = pickerMode;
        [self setupSubViews];
    }
    return self;
}


- (void)showView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 1;
        CGFloat modifyY = kUIScreenHeight - kDatePickerBackViewHeight;
        self.pickBackView.frame = CGRectMake(0, modifyY, kUIScreenWidth, kDatePickerBackViewHeight);
    }];
}

- (void)setupSubViews
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, kUIScreenHeight, kUIScreenWidth, kDatePickerBackViewHeight)];
    backView.backgroundColor = RGBColor(100, 100, 100);
    UITapGestureRecognizer *backViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewTapWithNoAction)];
    [backView addGestureRecognizer:backViewTap];
    self.pickBackView = backView;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, 0, kButtonWidth, kButtonHeight);
    [backView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.frame = CGRectMake(kUIScreenWidth - kButtonWidth, 0, kButtonWidth, kButtonHeight);
    [backView addSubview:confirmBtn];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kButtonWidth, 0, kUIScreenWidth - 2 * kButtonWidth, kButtonHeight)];
     NSDate *currentDate = [NSDate date];
    timeLabel.text = [self.formatter stringFromDate:currentDate];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel = timeLabel;
    [backView addSubview:timeLabel];
    
    UIDatePicker *picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kButtonHeight , kUIScreenWidth, kDatePickerHeight)];
    [picker setDatePickerMode:self.pickerMode];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    picker.locale = locale;
    picker.backgroundColor = [UIColor whiteColor];
    [picker addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
    [backView addSubview:picker];
    
    self.pickView = picker;
    
    [self addSubview:backView];
}

- (void)setDisableMaximumDate:(BOOL)disableMaximumDate
{
    _disableMaximumDate = disableMaximumDate;
    if (disableMaximumDate) {
        self.pickView.maximumDate = [NSDate date];
    }else{
        self.pickView.maximumDate = nil;
    }
}

-(void)setMinDate:(NSDate *)minDate{
    _minDate = minDate;
    if (minDate) {
        self.pickView.minimumDate = minDate;
    }
}

- (void)cancelBtnClicked
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 0;
        self.pickBackView.frame = CGRectMake(0, kUIScreenHeight, kUIScreenWidth, kDatePickerBackViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)confirmBtnClicked
{

    if (self.dateStrBlock) {
        self.dateStrBlock(self.timeLabel.text);
    }
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 0;
        self.pickBackView.frame = CGRectMake(0, kUIScreenHeight, kUIScreenWidth, kDatePickerBackViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dataValueChanged:(UIDatePicker *)picker
{
    NSDate *date_one = picker.date;
    self.timeLabel.text = [self.formatter stringFromDate:date_one];
    if ([_delegate respondsToSelector:@selector(getDate:)]) {
        [_delegate getDate:date_one];
    }
}

- (void)backViewTapWithNoAction
{//should do nothing here
    
}

@end
