//
//  VerificationCodeView.h
//  LeChe
//
//  Created by yangxuran on 2018/3/20.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerificationCodeView : UIView

@property (nonatomic, copy) void (^codeBlock) (NSString *codeStr);
/// 输入文本框
@property (nonatomic, strong) UITextField *codeTextField;

- (instancetype)initWithFrame:(CGRect)frame andLabelCount:(NSInteger)labelCount;

@end
