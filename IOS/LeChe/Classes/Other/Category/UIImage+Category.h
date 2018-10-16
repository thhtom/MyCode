//
//  UIImage+Category.h
//  ChengMi
//
//  Created by Lixiaopeng on 2018/1/9.
//  Copyright © 2018年 宋媛媛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

@end
