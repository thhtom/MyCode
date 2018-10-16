//
//  UIViewController+Push.m
//  LeChe
//
//  Created by yangxuran on 2018/3/26.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "UIViewController+Push.h"
#import "BFDCollectionViewController.h"
#import "BFDMyReserveViewController.h"

@implementation UIViewController (Push)

/*
 * 浏览记录
 */
-(void)toBrowsing{
    BFDCollectionViewController *collecVC = [[BFDCollectionViewController alloc] init];
    collecVC.index = 0;
    [self.navigationController pushViewController:collecVC animated:YES];
}

/*
 * 我的收藏
 */
-(void)toCollection{
    BFDCollectionViewController *collecVC = [[BFDCollectionViewController alloc] init];
    collecVC.index = 0;
    [self.navigationController pushViewController:collecVC animated:YES];
}

/*
 * 我的预约
 */
-(void)toYuyue{
    BFDMyReserveViewController *reserveVC = [[BFDMyReserveViewController alloc] init];
    [self.navigationController pushViewController:reserveVC animated:YES];
}

/*
 * 我的订单
 */
-(void)toOrder{
    
}

/*
 * 关于我们
 */
-(void)toAboutUs{
    
}

/*
 * 意见反馈
 */
-(void)toFeedback{
    
}

-(void)login{
    
}

@end
