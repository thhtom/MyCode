//
//  QuickCreate.m
//  CloudClassroom
//
//  Created by yangxuran on 2018/9/14.
//  Copyright © 2018年 dfws. All rights reserved.
//

#import "QuickCreate.h"

@implementation QuickCreate

+(UILabel *)createLabelWithFrame:(CGRect)frame
                            text:(NSString *)text
                       textColor:(UIColor *)textColor
                        fontSize:(CGFloat)fontSize
                   textAlignment:(NSTextAlignment)textAlignment
                   numberOfLines:(NSInteger)numberOfLines
                          isBold:(BOOL)isBold
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (isBold) {
        label.font = [UIFont boldSystemFontOfSize:RSS(fontSize)];
    }else{
        label.font = [UIFont systemFontOfSize:RSS(fontSize)];
    }
    label.textColor = textColor;
    label.text = text;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    
    return label;
}

//创建UIButton
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                              color:(UIColor *)color
                           fontSize:(CGFloat)fontSize
                    backgroundColor:(UIColor *)backgroundColor
                       cornerRadius:(CGFloat)cornerRadius
                             isBold:(BOOL)isBold
                             target:(id)target
                             action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.masksToBounds = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (isBold) {
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:RSS(fontSize)];
    }else{
        btn.titleLabel.font = [UIFont systemFontOfSize:RSS(fontSize)];
    }
    btn.backgroundColor = backgroundColor;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

//创建UITextField
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                    color:(UIColor *)color
                                 fontSize:(CGFloat)fontSize
                          secureTextEntry:(BOOL)secureTextEntry
                                 delegate:(id)delegate
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.font = [UIFont systemFontOfSize:RSS(fontSize)];
    textField.secureTextEntry = secureTextEntry;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.delegate = delegate;
    
    return textField;
}

//创建UITextView
+ (UITextView *)commonTextViewWithFrame:(CGRect)frame
                                   text:(NSString *)text
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                          textAlignment:(NSTextAlignment)textAlignment
{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.text = text;
    textView.textColor = color;
    textView.textAlignment = textAlignment;
    
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    
    return textView;
}

@end
