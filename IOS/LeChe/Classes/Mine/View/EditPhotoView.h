//
//  EditPhotoView.h
//  LeChe
//
//  Created by yangxuran on 2018/3/23.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPhotoView : UIView

@property (nonatomic, copy) void (^action) (NSInteger index);

-(void)showView;

@end
