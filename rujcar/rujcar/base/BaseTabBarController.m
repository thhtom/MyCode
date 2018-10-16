//
//  BaseTabBarController.m
//  rujcar
//
//  Created by 佰福大 on 17/09/18.
//  Copyright © 2018年 TOM. All rights reserved.
//

#import "BaseTabBarController.h"
#import "AppDelegate.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    ((AppDelegate *)[UIApplication sharedApplication].delegate).tabController =self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    [self initTab];
    
   
    
    // Do any additional setup after loading the view.
}

- (void)initTab{
    
    NSArray <NSString*> *titleList = @[@"首页",@"服务",@"我的"];
    NSArray <NSString*> *imageList = @[@"home",@"server",@"my"];
    NSArray <NSString*> *unImageList = @[@"un_home",@"un_server",@"un_my"];
    
    NSArray <UIViewController *> *controllerList = @[[UIViewController new],[UIViewController new],[UIViewController new]];
    

    for (int i=0; i<titleList.count; i++) {
        UITabBarItem *Bar = [[UITabBarItem alloc]initWithTitle:titleList[i] image:[UIImage imageNamed:imageList[i]] selectedImage:[UIImage imageNamed:unImageList[i]]];
        
        controllerList[i].tabBarItem = Bar;
        controllerList[i].view.backgroundColor = [UIColor colorWithRed:255/(i+1)/255.0 green:255/(i+1)/255.0 blue:255/(i+1)/255.0 alpha:1.0];
        controllerList[i].tabBarItem.tag = [titleList[i] intValue];
    }
    self.viewControllers = controllerList;
    self.selectedIndex = 0;
    
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return  YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
