//
//  UIImage+ScaledSize.m
//

#import "UIImage+ScaledSize.h"

@implementation UIImage (ScaledSize)

- (UIImage *)imagesScaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
