//
//  VerificationCodeView.m
//  LeChe
//
//  Created by yangxuran on 2018/3/20.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "VerificationCodeView.h"

static CGFloat const margin = 10;

@interface VerificationCodeView()<UITextFieldDelegate>

/// 存放 label 的数组
@property (nonatomic, strong) NSMutableArray *labelArr;
/// label 的数量
@property (nonatomic, assign) NSInteger labelCount;

@end

@implementation VerificationCodeView

- (instancetype)initWithFrame:(CGRect)frame andLabelCount:(NSInteger)labelCount{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.labelCount = labelCount;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    CGFloat labelX;
    CGFloat labelY = 0;
    CGFloat labelWidth = (self.width - (self.labelCount - 1) * margin) / self.labelCount ;
    for (int i = 0; i < self.labelCount; i++) {
        if (i == 0) {
            labelX = 0;
        } else {
            labelX = i * (labelWidth + margin);
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, self.height)];
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:44];
        label.textColor = RGBA(204, 204, 204, 1);
        [self.labelArr addObject:label];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(labelX, CGRectGetMaxY(label.frame), labelWidth, 1)];
        lineView.backgroundColor = RGBColor(204, 204, 204);
        [self addSubview:lineView];
    }
    
    [self addSubview:self.codeTextField];
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSInteger i = textField.text.length;
    if (i == 0) {
        ((UILabel *)[self.labelArr objectAtIndex:0]).text = @"";
    } else {
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).text = [NSString stringWithFormat:@"%C", [textField.text characterAtIndex:i - 1]];
        if (self.labelCount > i) {
            ((UILabel *)[self.labelArr objectAtIndex:i]).text = @"";
        }
    }
    if (self.codeBlock) {
        self.codeBlock(textField.text);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        return YES;
    } else if (textField.text.length >= self.labelCount) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - 懒加载
- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.height)];
        _codeTextField.backgroundColor = [UIColor clearColor];
        _codeTextField.textColor = [UIColor clearColor];
        _codeTextField.tintColor = [UIColor clearColor];
        _codeTextField.delegate = self;
        _codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_codeTextField];
    }
    return _codeTextField;
}

#pragma mark - 懒加载
- (NSMutableArray *)labelArr {
    if (!_labelArr) {
        _labelArr = [NSMutableArray array];
    }
    return _labelArr;
}


@end
