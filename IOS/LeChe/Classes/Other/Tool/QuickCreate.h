//
//  QuickCreate.h
//  CloudClassroom
//
//  Created by yangxuran on 2018/9/14.
//  Copyright © 2018年 dfws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickCreate : NSObject

//创建UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame
                            text:(NSString *)text
                       textColor:(UIColor *)textColor
                        fontSize:(CGFloat)fontSize
                   textAlignment:(NSTextAlignment)textAlignment
                   numberOfLines:(NSInteger)numberOfLines
                          isBold:(BOOL)isBold;

//创建UIButton
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                              color:(UIColor *)color
                               fontSize:(CGFloat)fontSize
                    backgroundColor:(UIColor *)backgroundColor
                       cornerRadius:(CGFloat)cornerRadius
                             isBold:(BOOL)isBold
                             target:(id)target
                             action:(SEL)action;

//创建UITextField
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                    color:(UIColor *)color
                                     fontSize:(CGFloat)fontSize
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate;

//创建UITextView
+ (UITextView *)commonTextViewWithFrame:(CGRect)frame
                                   text:(NSString *)text
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                          textAlignment:(NSTextAlignment)textAlignment;

@end
