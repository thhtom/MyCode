//
//  BFDHomeHeaderView.h
//  LeChe
//
//  Created by yangxuran on 2018/9/17.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFDHomeHeaderViewDelegate <NSObject>

@optional
-(void)brandClick:(NSInteger)index;

@end

@interface BFDHomeHeaderView : UIView

@property (nonatomic, weak) id<BFDHomeHeaderViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)configDataWithBannerAry:(NSArray *)bannerAry brandAry:(NSArray *)brandAry;

@end
