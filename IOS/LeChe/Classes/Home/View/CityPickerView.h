//
//  CityPickerView.h
//  LeChe
//
//  Created by yangxuran on 2018/3/23.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityPickerView : UIView

@property (nonatomic, copy) void (^action) (NSString *city);

-(instancetype)initWithFrame:(CGRect)frame;

-(void)showView;
-(void)hiddenView;

@end
