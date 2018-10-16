//
//  BaseTableViewController.h
//  LeChe
//
//  Created by yangxuran on 2018/2/28.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface BaseTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    
    NSInteger _currentPage;
}

/**
 初始化方法
 @param style 默认为UITableViewStylePlain
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSourceList;

/**
 同时集成上拉刷新与下拉加载更多
 */
- (void)addRefreshControl;
/**
 只集成上拉刷新
 */
- (void)addHeaderRefreshControl;
/**
 只集成下拉加载更多
 */
- (void)addFooterRefreshControl;

/**
 有刷新控件的情况下通过该方法加载数据
 */
- (void)loadDataListWithPage: (NSInteger)page;

@end
