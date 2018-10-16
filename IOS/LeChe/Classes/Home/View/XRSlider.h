//
//  XRSlider.h
//  slider
//
//  Created by yangxuran on 2018/5/10.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRSlider : UIView

@property (nonatomic, copy) void (^valueChangeBlock) (NSInteger index);

-(instancetype)initWithFrame:(CGRect)frame titleAry:(NSArray *)titleAry;

-(void)setSelectIndex:(NSInteger)index;

@end
