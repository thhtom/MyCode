//
//  UIButton+ChangePosition.m
//  LeChe
//
//  Created by yangxuran on 2018/9/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "UIButton+ChangePosition.h"

@implementation UIButton (ChangePosition)

-(void)buttonImageOnRight{
    
    CGFloat margin = 5;
    CGFloat imageWith = self.imageView.frame.size.width;
    
    CGFloat labelWidth = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + margin, 0, -(labelWidth + margin));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
}

@end
