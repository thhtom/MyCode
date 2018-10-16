//
//  PhotoManager.h
//  NanJingJiaoDao
//
//  Created by Remmo on 16/11/9.
//  Copyright © 2016年 xxx. All rights reserved.
//

//  使用注意： 需要将PhotoManager的实例设置为对象的属性或成员变量

#import <Foundation/Foundation.h>

typedef void(^PhotoSelectedCallback)(UIImage *selectedImage);

@interface PhotoManager : NSObject

@property (nonatomic, assign) BOOL allowsEditing;

+ (instancetype)manager;

- (void)selectPhotoWithTitle:(NSString *)title viewController:(UIViewController *)viewController photoCallback:(PhotoSelectedCallback)photoCallback;

@end
