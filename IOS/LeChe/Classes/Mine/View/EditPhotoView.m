//
//  EditPhotoView.m
//  LeChe
//
//  Created by yangxuran on 2018/3/23.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "EditPhotoView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

static CGFloat const aspectRatio = 69 / 35.0;
static CGFloat const margin = 15;
static int const count = 2;

@interface EditPhotoView()

@property (nonatomic, weak) UIView *contentView;

@end

@implementation EditPhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubView];
    }
    return self;
}

-(void)addSubView{
    
    CGFloat contentWidth = WIDTH - margin * 2;
    CGFloat contentHeight = contentWidth / aspectRatio;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    bgView.backgroundColor = RGBAColor(0, 0, 0, 0.8);
    [self addSubview:bgView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(margin, 170, contentWidth, contentHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    [bgView addSubview:contentView];
    self.contentView = contentView;
    
    NSArray *btnTitleAry = @[@"拍照",@"从相册选择"];
    NSArray *btnImgAry = @[@"mine_edit_photograph",@"mine_edit_picture"];
    CGFloat btnWH = 150;
    CGFloat leftMargin = (contentWidth - btnWH * count) / (count + 1);
    CGFloat topMargin = (contentHeight - btnWH) / 2;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(leftMargin + btnWH * i + leftMargin * i, topMargin, btnWH, btnWH);
        [btn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
        [btn setTitle:btnTitleAry[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btnImgAry[i]] forState:UIControlStateNormal];
        btn.titleLabel.font = Font(16);
        
        [btn click:^(id value) {
            if (self.action) {
                self.action(i);
            }
            [self hiddenView];
        }];
        
        [self initButton:btn];
        [contentView addSubview:btn];
    }
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(contentWidth - 40, 0, 40, 40);
    [cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    
     [cancelBtn click:^(id value) {
         [self hiddenView];
     }];
    
    [contentView addSubview:cancelBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.width = 0.5;
    lineView.height = contentHeight - 70;
    lineView.backgroundColor = RGBColor(204, 204, 204);
    lineView.center = CGPointMake(contentWidth / 2, contentHeight / 2);
    [contentView addSubview:lineView];
}

-(void)initButton:(UIButton*)btn{
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0,0.0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-40, 0.0,0.0, -(btn.titleLabel.bounds.size.width))];
}

#pragma mark - show & hidden
- (void)showView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)hiddenView{
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([touches anyObject].view != self.contentView) {
        [self hiddenView];
    }
}

@end
