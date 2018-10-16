//
//  CarSitePickerView.h
//  UIPickerView
//
//  Created by yangxuran on 2018/3/8.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarSitePickerView : UIView

@property (nonatomic, copy) void (^action) (NSString *site);

-(instancetype)initWithFrame:(CGRect)frame dataAry:(NSArray *)dataAry;

-(void)showView;
-(void)hiddenView;

@end
