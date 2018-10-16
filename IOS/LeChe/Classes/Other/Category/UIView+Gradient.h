//
//  UIView+Gradual.h
//  CloudClassroom
//
//  Created by yangxuran on 2018/9/14.
//  Copyright © 2018年 dfws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gradient)


/*
 * 添加渐变色
 */
-(void)addGradient;

/**
 添加渐变色

 @param startColor 起始颜色
 @param endColor 结束颜色
 */
-(void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

/*
 * 按钮添加渐变色（需要重新设置title的按钮）
 */
-(void)buttonAddGradinet;


@end
