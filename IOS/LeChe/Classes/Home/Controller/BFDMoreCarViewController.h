//
//  BFDMoreCarViewController.h
//  LeChe
//
//  Created by yangxuran on 2018/9/19.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger, ClassType){
    ClassTypeBrand = 0, //品牌
    ClassTypeCLass, //分类
};

@interface BFDMoreCarViewController : UIViewController

@property (nonatomic, assign) ClassType classType;
@property (nonatomic, copy) NSString *classID;
@property (nonatomic, copy) NSString *brandID;

@end
