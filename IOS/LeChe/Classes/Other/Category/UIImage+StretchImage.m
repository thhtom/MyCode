//
//  UIImage+StretchImage.m
//  BocGuest
//
//  Created by Remmo on 15/12/16.
//  Copyright © 2015年 xxx. All rights reserved.
//

#import "UIImage+StretchImage.h"

@implementation UIImage (StretchImage)

+ (UIImage *)stretchImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
