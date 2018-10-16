//
//  CarSitePickerView.m
//  UIPickerView
//
//  Created by yangxuran on 2018/3/8.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "CarSitePickerView.h"
#import "BFDSiteModel.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

static CGFloat const cityViewH  = 256;
static CGFloat const cancelBtnH = 40;

@interface CarSitePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) UIView *siteView;
@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, copy) NSString *seletedStr;

@end


@implementation CarSitePickerView

-(instancetype)initWithFrame:(CGRect)frame dataAry:(NSArray *)dataAry{
    if (dataAry.count == 0) {
        [BOCProgressHUD boc_ShowError:@"当前车辆没有门店"];
        return nil;
    }
    if (self = [super initWithFrame:frame]) {
        [self createSitePickerView];
        self.dataAry = dataAry;
    }
    return self;
}

-(void)createSitePickerView{
    UIView *siteView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, cityViewH)];
    siteView.backgroundColor = RGBColor(100, 100, 100);
    [self addSubview:siteView];
    self.siteView = siteView;
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, cancelBtnH, WIDTH, cityViewH - cancelBtnH)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    [siteView addSubview:pickerView];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, cancelBtnH)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [siteView addSubview:cancelBtn];
    
    UIButton *completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 50, 0, 50, cancelBtnH)];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [siteView addSubview:completeBtn];
}

-(void)cancelBtnClick{
    [self hiddenView];
}

-(void)completeBtnClick{
    if (self.action) {
        self.action(self.seletedStr);
    }
    [self hiddenView];
}

#pragma mark - UIPickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataAry.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    BFDSiteModel *model = self.dataAry[row];
    
    return model.area;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    BFDSiteModel *model = self.dataAry[row];
    self.seletedStr = model.area;
}

#pragma mark - show & hidden

- (void)showView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.25 animations:^{
        self.siteView.frame = CGRectMake(0, HEIGHT - cityViewH, WIDTH, cityViewH);
        self.backgroundColor = RGBAColor(0, 0, 0, 0.5);
        self.alpha = 1;
    } completion:^(BOOL finished) {
        BFDSiteModel *model = self.dataAry.firstObject;
        self.seletedStr = model.area;
    }];
}

- (void)hiddenView{
    [UIView animateWithDuration:.25 animations:^{
        self.siteView.frame = CGRectMake(0, HEIGHT, WIDTH, cityViewH);
        self.backgroundColor = RGBAColor(0, 0, 0, 0.0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([touches anyObject].view != self.siteView) {
        [self hiddenView];
    }
}

@end
