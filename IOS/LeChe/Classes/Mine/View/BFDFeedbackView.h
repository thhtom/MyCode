//
//  BFDFeedbackView.h
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFDFeedbackView : UIView

@property (nonatomic, copy) void (^cancelBlock) (void);
@property (nonatomic, copy) void (^commitBlock) (NSString *feedback);

+(instancetype)createFeedBackView;

@end
