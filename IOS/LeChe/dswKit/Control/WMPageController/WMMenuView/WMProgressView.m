//
//  WMProgressView.m
//  WMPageController
//
//  Created by Mark on 15/6/20.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMProgressView.h"
@implementation WMProgressView {
    int                     sign;
    CGFloat                 gap;
    CGFloat                 step;
    __weak CADisplayLink    *_link;

    UIView *lineView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        lineView = [[UIView alloc]init];
        lineView.height = self.height;
        lineView.left = 0;
        lineView.top = 0;
        _progress = -1;
        [self addSubview:lineView];
    }

    return self;
}

- (void)setColor:(CGColorRef)color {
    _color = color;
    lineView.backgroundColor = [UIColor colorWithCGColor:self.color];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    CGFloat cutNumber = RSS(30);
    if (self.itemFrames.count >= 4) {
        cutNumber = RSS(25);
    }
    lineView.width = APP_WIDTH/self.itemFrames.count - cutNumber*2;
    if ((int)progress == progress) {
        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            lineView.left = APP_WIDTH/self.itemFrames.count * progress+cutNumber;
        } completion:^(BOOL finished) {
            lineView.left = APP_WIDTH/self.itemFrames.count * progress+cutNumber;
        }];
    } else {
        lineView.left = APP_WIDTH/self.itemFrames.count * progress+cutNumber;
    }
}

@end
