//
//  UIView+Layer.m
//  KunQuanFinancial
//
//  Created by Remmo on 2017/7/21.
//  Copyright © 2017年 bocweb. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)

- (void)layerWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end
