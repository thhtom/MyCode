//
//  BFDCommonProblemViewController.m
//  LeChe
//
//  Created by yangxuran on 2018/5/4.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDCommonProblemViewController.h"
#import "BFDCommonProblemTableViewCell.h"
#import "BFDProblemModel.h"
#import "BFDBaseProblemModel.h"

static CGFloat headerHeight = 30;

@interface BFDCommonProblemViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIButton *lastSelectedBtn;
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) NSArray *currentAry;

@end

@implementation BFDCommonProblemViewController

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight - (kNavigationBarHeight + kTabbarHeight)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)dataAry{
    if (!_dataAry) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常见问题";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self createHeaderView];
    [self createFooterView];
}

-(void)getData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"problem" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    for (NSDictionary *dict in dic[@"data"]) {
        BFDBaseProblemModel *model = [BFDBaseProblemModel mj_objectWithKeyValues:dict];
        [self.dataAry addObject:model];
    }
}

-(UIView *)createHeaderView{
    
    NSArray *titleAry = @[@"关于如鲸",@"资料及审核",@"首付及分期",@"保险及上牌",@"关于售后",@"其他问题"];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, RSS(163))];
    headerView.backgroundColor = [UIColor whiteColor];
    
    int count = 3;
    CGFloat leftMargin = RSS(22);
    CGFloat topMargin = RSS(30);
    CGFloat marginX = RSS(16);
    CGFloat marginY = RSS(25);
    CGFloat width = ((kUIScreenWidth - leftMargin * 2) - marginX * (count - 1)) / count;
    CGFloat height = RSS(37);
    for (int i = 0; i < 6; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(leftMargin + (width + marginX) * (i % count), topMargin + (height + marginY) * (i / count), width, height);
        [btn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = Font(14);
        [btn setTitle:titleAry[i] forState:UIControlStateNormal];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = RGBA(51, 51, 51, 1).CGColor;
        if (i == 0) {
            btn.backgroundColor = kFirstTextColor;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.lastSelectedBtn = btn;
            self.currentAry = [self.dataAry[i] list];
            [self.tableView reloadData];
        }
        [btn click:^(id value) {
            self.lastSelectedBtn.backgroundColor = [UIColor whiteColor];
            [self.lastSelectedBtn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
            btn.backgroundColor = btn.backgroundColor = RGBA(51, 51, 51, 1);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.lastSelectedBtn = btn;
            self.currentAry = [self.dataAry[i] list];
            [self.tableView reloadData];
        }];
        
        [headerView addSubview:btn];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.height - 1, kUIScreenWidth, 0.5)];
    lineView.backgroundColor = RGBColor(245, 245, 245);
    [headerView addSubview:lineView];
    
    return headerView;
}


-(void)createFooterView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kUIScreenHeight - kNavigationBarHeight - 50 - kSafeBottomHeight, kUIScreenWidth, 50);
    [btn addGradient];
    [btn setTitle:@"联系客服" forState:UIControlStateNormal];
    [btn setTitleColor:kFirstTextColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    [btn click:^(id value) {
        [AppUtil dial:@"400-9696-726"];
    }];
    
    [self.view addSubview:btn];
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.currentAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BFDProblemModel *model = self.currentAry[section];
    return model.isHidden ? 0 : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFDCommonProblemTableViewCell *cell = [BFDCommonProblemTableViewCell cellWithTableView:tableView];
    cell.model = self.currentAry[indexPath.section];
    return cell;
}


#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kUIScreenWidth - 70, RSS(16))];
    label.font = [UIFont systemFontOfSize:RSS(16)];
    label.textColor = kFirstTextColor;
    label.text = [self.currentAry[section] title];
    [view addSubview:label];
    
    CGFloat btnWH = RSS(16);
    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downBtn.frame = CGRectMake(kUIScreenWidth - btnWH - 15, 0, btnWH, btnWH);
    [downBtn setImage:Img(@"arrow_down") forState:UIControlStateNormal];
    downBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
//    downBtn.centerY = headerHeight / 2;
    [view addSubview:downBtn];
    
    BFDProblemModel *model = self.currentAry[section];
    if (model.isHidden) {
        downBtn.imageView.transform = CGAffineTransformIdentity;
    }
    
    [downBtn click:^(id value) {
        BFDProblemModel *model = self.currentAry[section];
        model.isHidden = !model.isHidden;

        // 刷新某一组
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:section];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    }];

    return view;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return RSS(headerHeight);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *content = [self.currentAry[indexPath.section] content];
    CGFloat height = [content sizeWithFont:Font(14) maxW:(kUIScreenWidth - 40)].height;
    
    return height + 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
