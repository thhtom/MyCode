//
//  CityPickerView.m
//  LeChe
//
//  Created by yangxuran on 2018/3/23.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "CityPickerView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

static CGFloat const cityViewH  = 256;
static CGFloat const cancelBtnH = 40;

@interface CityPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>{
    
    NSInteger _provinceIndex;   // 省份选择 记录
    NSInteger _cityIndex;       // 市选择 记录
    NSInteger _districtIndex;   // 区选择 记录
}

@property (nonatomic, weak) UIView *cityView;
@property (nonatomic, weak) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *dataAry;

@end

@implementation CityPickerView

-(NSArray *)dataAry{
    if(!_dataAry){
        NSString * path = [[NSBundle mainBundle] pathForResource:@"Province" ofType:@"plist"];
        _dataAry = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _dataAry;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCityView];
    }
    return self;
}


-(void)createCityView{
    UIView *cityView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, cityViewH)];
    cityView.backgroundColor = RGBColor(100, 100, 100);
    [self addSubview:cityView];
    self.cityView = cityView;
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, cancelBtnH, WIDTH, cityViewH - cancelBtnH)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    [cityView addSubview:pickerView];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, cancelBtnH)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cityView addSubview:cancelBtn];
    self.pickerView = pickerView;
    
    UIButton *completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH - 60, 0, 60, cancelBtnH)];
    [completeBtn setTitle:@"确定" forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cityView addSubview:completeBtn];
}

-(void)resetPickerSelectRow{
    [self.pickerView selectRow:_provinceIndex inComponent:0 animated:YES];
    [self.pickerView selectRow:_cityIndex inComponent:1 animated:YES];
    [self.pickerView selectRow:_districtIndex inComponent:2 animated:YES];
}


#pragma mark - 点击事件
-(void)cancelBtnClick{
    [self hiddenView];
}

-(void)completeBtnClick{
    
    if (self.action) {
    NSString * address = [NSString stringWithFormat:@"%@-%@-%@", self.dataAry[_provinceIndex][@"province"], self.dataAry[_provinceIndex][@"citys"][_cityIndex][@"city"], self.dataAry[_provinceIndex][@"citys"][_cityIndex][@"districts"][_districtIndex]];
        self.action(address);
    }
    
    [self hiddenView];
}


#pragma mark - PickerView Delegate
// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.dataAry.count;
    }
    else if (component == 1){
        return [self.dataAry[_provinceIndex][@"citys"] count];
    }
    else{
        return [self.dataAry[_provinceIndex][@"citys"][_cityIndex][@"districts"] count];
    }
}

// 返回每一行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0){
        return self.dataAry[row][@"province"];
    }
    else if (component == 1){
        return self.dataAry[_provinceIndex][@"citys"][row][@"city"];
    }
    else{
        return self.dataAry[_provinceIndex][@"citys"][_cityIndex][@"districts"][row];
    }
}

// 滑动或点击选择，确认pickerView选中结果
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(component == 0){
        _provinceIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
    }
    else if (component == 1){
        _cityIndex = row;
        _districtIndex = 0;
        
        [self.pickerView reloadComponent:2];
    }
    else{
        _districtIndex = row;
    }
    
    // 重置当前选中项
    [self resetPickerSelectRow];
}


#pragma mark - show & hidden
- (void)showView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.25 animations:^{
        self.cityView.frame = CGRectMake(0, HEIGHT - cityViewH, WIDTH, cityViewH);
        self.backgroundColor = RGBAColor(0, 0, 0, 0.5);
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenView{
    [UIView animateWithDuration:.25 animations:^{
        self.cityView.frame = CGRectMake(0, HEIGHT, WIDTH, cityViewH);
        self.backgroundColor = RGBAColor(0, 0, 0, 0.0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([touches anyObject].view != self.cityView) {
        [self hiddenView];
    }
}


@end
