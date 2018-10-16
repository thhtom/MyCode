//
//  BFDCalculatorViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/3/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDCalculatorViewController.h"
#import "BFDSelectCarViewController.h"

@interface BFDCalculatorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *addCarImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleBottomMargin;


@end

@implementation BFDCalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"计算器";
    self.titleBottomMargin.constant = RSS(20);
    
    [self.addCarImgView addTapGesture:^{
        BFDSelectCarViewController *selectCarVC = [[BFDSelectCarViewController alloc] init];
        [self.navigationController pushViewController:selectCarVC animated:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"CalculatorView"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"CalculatorView"];
}

@end
