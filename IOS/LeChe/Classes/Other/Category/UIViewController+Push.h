//
//  UIViewController+Push.h
//  LeChe
//
//  Created by yangxuran on 2018/3/26.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Push)

/*
 * 浏览记录
 */
-(void)toBrowsing;

/*
 * 我的收藏
 */
-(void)toCollection;

/*
 * 我的预约
 */
-(void)toYuyue;

/*
 * 我的订单
 */
-(void)toOrder;

/*
 * 关于我们
 */
-(void)toAboutUs;

/*
 * 意见反馈
 */
-(void)toFeedback;

-(void)login;


@end
