//
//  XRSlider.m
//  slider
//
//  Created by yangxuran on 2018/5/10.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "XRSlider.h"
#import "UIView+Gradient.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

static CGFloat const r = 10;
static CGFloat const d = 20;
static CGFloat const leftMargin = 25;
static CGFloat const pointLeftMargin = r + leftMargin;

@interface XRSlider()

@property (nonatomic, strong) UIButton *thumbBtn;
@property (nonatomic, weak) UIView *grayLineView;
@property (nonatomic, weak) UIImageView *redLineImg;
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) NSArray *colorAry;

@end

@implementation XRSlider

-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 50, 15)];
        _textLabel.textColor = RGBColor(51, 51, 51);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _textLabel;
}

-(NSMutableArray *)dataAry{
    if (!_dataAry) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

-(UIButton *)thumbBtn{
    if (!_thumbBtn) {
        _thumbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _thumbBtn.frame = CGRectMake(0, 0, 20, 20);
        _thumbBtn.layer.cornerRadius = _thumbBtn.frame.size.width / 2;
        _thumbBtn.backgroundColor = RGBColor(51, 51, 51);
        [_thumbBtn addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
        [_thumbBtn addTarget:self action:@selector(touchUp:withEvent:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
        [self addSubview:_thumbBtn];
    }
    return _thumbBtn;
}

-(instancetype)initWithFrame:(CGRect)frame titleAry:(NSArray *)titleAry{

    if (self = [super initWithFrame:frame]) {
        self.titleAry = titleAry;
        self.count = titleAry.count;
        self.colorAry = @[RGBColor(160, 123, 60), RGBColor(232, 202, 126)];
        [self createSlider];
    }
    return self;
}

-(void)setSelectIndex:(NSInteger)index{
    
    CGFloat lineWidth = (WIDTH - leftMargin * 2 - d * self.count) / (self.count - 1);
    
    for (int i = 0; i < self.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, d, d);
        btn.center = CGPointMake(leftMargin + (lineWidth + d) * i + r, 50);
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = RGBColor(204, 204, 204);
        NSString *str = self.titleAry[i];
        label.text = [str substringToIndex:str.length - 1];
        [label sizeToFit];
        label.center = CGPointMake(leftMargin + (lineWidth + d) * i + r, 69);
        [self addSubview:label];
        [self.dataAry addObject:label];
        
        if (i == index) {
            self.thumbBtn.center = CGPointMake(leftMargin + (lineWidth + d) * i + r, 50);
            self.redLineImg.frame = CGRectMake(0, 0, leftMargin + (lineWidth + d) * i + r - pointLeftMargin, 10);
            self.redLineImg.image = [self getGradientImageWithColors:self.colorAry imgSize:self.redLineImg.frame.size];
            self.textLabel.center = CGPointMake(leftMargin + (lineWidth + d) * i + r, 15);
            self.textLabel.text = self.titleAry[index];
            
            UILabel *currentLabel = self.dataAry[index];
            currentLabel.textColor = [UIColor whiteColor];
        }
    
        [self addSubview:btn];
    }

    self.valueChangeBlock(index);
    
    [self bringSubviewToFront:self.thumbBtn];
}

-(void)createSlider{
    
    UIView *grayLineView = [[UIView alloc] initWithFrame:CGRectMake(leftMargin + r, 45, WIDTH - (leftMargin + r) * 2, 10)];
    grayLineView.backgroundColor = RGBColor(235, 235, 235);
    grayLineView.layer.cornerRadius = 4;
    [self addSubview:grayLineView];
    self.grayLineView = grayLineView;
    
    UIImageView *redImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - (leftMargin + r) * 2, 10)];
    redImg.layer.cornerRadius = 4;
    redImg.layer.masksToBounds = YES;
    [grayLineView addSubview:redImg];
    self.redLineImg = redImg;
    
    [self addSubview:self.textLabel];
}

#pragma  mark - 滑动
- (void) TouchMove: (UIButton *) btn withEvent: (UIEvent *) ev {
    
    self.textLabel.text = @"";
    CGRect frame = self.thumbBtn.frame;
    frame.size = CGSizeMake(30, 30);
    self.thumbBtn.frame = frame;
    _thumbBtn.layer.cornerRadius = _thumbBtn.frame.size.width / 2;
    
    for (UILabel *label in self.dataAry) {
        label.textColor = RGBColor(204, 204, 204);
    }
    
    CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
    
    //防止滑块滑出范围
    if (currPoint.x < pointLeftMargin) {
        currPoint.x = pointLeftMargin;
    }
    if (currPoint.x > WIDTH - pointLeftMargin) {
        currPoint.x = WIDTH - pointLeftMargin;
    }
    self.thumbBtn.center = CGPointMake(currPoint.x, 50);
    self.redLineImg.frame = CGRectMake(0, 0, currPoint.x - pointLeftMargin, 10);
    self.redLineImg.image = [self getGradientImageWithColors:self.colorAry imgSize:self.redLineImg.frame.size];
    
    CGFloat lineWidth = (WIDTH - leftMargin * 2 - d * self.count) / (self.count - 1);
    
    int index = (currPoint.x - pointLeftMargin) / (lineWidth + d);
    
    self.valueChangeBlock(index);
}


-(void)touchUp:(UIButton *)btn withEvent:(UIEvent *)event{
    
    CGFloat lineWidth = (WIDTH - leftMargin * 2 - d * self.count) / (self.count - 1);
    
    CGPoint currPoint = [[[event allTouches] anyObject] locationInView:self];
    int index = (currPoint.x - pointLeftMargin) / (lineWidth + d);
    CGFloat minX = leftMargin + (lineWidth + d) * index + r;
    if ((currPoint.x - minX) >= lineWidth / 2 && currPoint.x < WIDTH - pointLeftMargin) {
        index += 1;
    }
    
    self.valueChangeBlock(index);
    self.textLabel.center = CGPointMake(leftMargin + (lineWidth + d) * index + r, 15);
    self.textLabel.text = self.titleAry[index];

    [UIView animateWithDuration:0.4 animations:^{
        self.redLineImg.frame = CGRectMake(0, 0, (lineWidth + d) * index + r, 10);
        self.redLineImg.image = [self getGradientImageWithColors:self.colorAry imgSize:self.redLineImg.frame.size];
        
        CGRect frame = self.thumbBtn.frame;
        frame.size = CGSizeMake(20, 20);
        self.thumbBtn.frame = frame;
        self.thumbBtn.layer.cornerRadius = self.thumbBtn.frame.size.width / 2;
        self.thumbBtn.center = CGPointMake(leftMargin + (lineWidth + d) * index + r, 50);
        
        UILabel *currentLabel = self.dataAry[index];
        currentLabel.textColor = [UIColor whiteColor];
    }];
}

#pragma mark - 生成渐变颜色
-(UIImage *)getGradientImageWithColors:(NSArray*)colors imgSize:(CGSize)imgSize
{
    NSMutableArray *arRef = [NSMutableArray array];
    for(UIColor *ref in colors) {
        [arRef addObject:(id)ref.CGColor];
        
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)arRef, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(imgSize.width, imgSize.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}




@end
