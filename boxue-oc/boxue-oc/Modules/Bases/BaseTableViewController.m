//
//  BaseTableViewController.m
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewCell.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    // init 时做的事情请写在这里
}

- (void)initTableView {
    [super initTableView];
    // 对 self.tableView 的操作写在这里
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 对 self.view 的操作写在这里
    
    if (self.cellClass) {
        [self.tableView registerClass:self.cellClass forCellReuseIdentifier:[self.cellClass CellReuseIdentifier]];
        
        if ([self.cellClass CellHeight] > 0) {
            self.tableView.rowHeight = [self.cellClass CellHeight];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"<##>";
}


- (void)startRefresh{
    self.isRefreshing = YES;
    self.datas = [NSMutableArray array];
    self.error = nil;
    [self reloadEmptyView];
    
    __weak __typeof(self)weakSelf = self;
    [self refreshComplete:^(NSArray *datas, NSError *error) {
        __strong __typeof(weakSelf)self = weakSelf;
        self.isRefreshing = NO;
        if (error) {
            self.error = error;
        }else{
            if (datas.count > 0) {
                [self.datas addObjectsFromArray:datas];
            }
        }
        [self.tableView reloadData];
        [self reloadEmptyView];
    }];
    
}


- (void)refreshComplete:(void (^)(NSArray *, NSError *))complete{
    if (complete) {
        complete(nil, nil);
    }
}

#pragma mark - 工具方法

- (void)reloadEmptyView{
    if (self.datas.count > 0) {
        [self hideEmptyView];
    }else{
        if (self.isRefreshing) {
            [self showEmptyViewWithLoading];
        }else{
            [self showEmptyViewWithText:@"提示" detailText:self.error?@"加载出错":@"暂无数据" buttonTitle:@"点击重试" buttonAction:@selector(startRefresh)];
        }
    }
}

#pragma mark - <QMUITableViewDataSource, QMUITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellClass) {
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.cellClass CellReuseIdentifier]];
        [cell updateViewsWithModels:[self.datas objectAtIndex:indexPath.row]];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 屏幕旋转

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.supportedOrientationMask;
}


@end
