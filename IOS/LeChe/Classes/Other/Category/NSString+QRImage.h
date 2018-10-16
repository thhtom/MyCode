//
//  NSString+QRImage.h
//  ETong
//
//  Created by Remmo on 17/1/14.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QRImage)

- (UIImage *)encodeQRImageWithSize:(CGSize)size;

@end
