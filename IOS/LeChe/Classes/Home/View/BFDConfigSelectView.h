//
//  BFDConfigSelectView.h
//  LeChe
//
//  Created by yangxuran on 2018/9/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFDConfigModel;

@protocol BFDConfigSelectViewDelegate <NSObject>
@optional

-(void)selectConfigWithModel:(BFDConfigModel *)model;

@end

@interface BFDConfigSelectView : UIView

@property (nonatomic, weak) id <BFDConfigSelectViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;

-(void)setDataWithLeftAry:(NSArray *)leftAry rightAry:(NSArray *)rightAry;

-(void)hiddenView;

@end
