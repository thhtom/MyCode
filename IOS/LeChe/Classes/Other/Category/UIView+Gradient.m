//
//  UIView+Gradual.m
//  CloudClassroom
//
//  Created by yangxuran on 2018/9/14.
//  Copyright © 2018年 dfws. All rights reserved.
//

#import "UIView+Gradient.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

@implementation UIView (Gradient)

/*
 * 添加渐变色
 */
-(void)addGradient{
    [self addGradientWithStartColor:RGBA(160, 123, 60, 1) endColor:RGBA(232, 202, 126, 1)];
}

/**
 添加渐变色
 
 @param startColor 起始颜色
 @param endColor 结束颜色
 */
-(void)addGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(UIColor *)startColor.CGColor, (UIColor *)endColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.locations = @[@0,@1];
    
    [self.layer addSublayer:gradientLayer];
}

/*
 * 按钮添加渐变色（需要重新设置title的按钮）
 */
-(void)buttonAddGradinet{
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        UIImage *img = [self getGradientImageWithColors:@[RGBA(160, 123, 60, 1), RGBA(232, 202, 126, 1)] imgSize:btn.size];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
    }
}

#pragma mark - 生成渐变颜色
-(UIImage *)getGradientImageWithColors:(NSArray*)colors imgSize:(CGSize)imgSize
{
    NSMutableArray *arRef = [NSMutableArray array];
    for(UIColor *ref in colors) {
        [arRef addObject:(id)ref.CGColor];
        
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)arRef, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(imgSize.width, imgSize.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


@end
