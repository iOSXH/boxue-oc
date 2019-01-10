//
//  BaseTableViewController.h
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import "QMUICommonTableViewController.h"

@interface BaseTableViewController : QMUICommonTableViewController

/**
 cell类
 */
@property(nonatomic, assign) Class cellClass;

/**
 数据数组
 */
@property(nonatomic, strong) NSMutableArray *datas;

/**
 是否刷新中
 */
@property(nonatomic, assign) BOOL isRefreshing;

/**
 错误
 */
@property(nonatomic, strong) NSError *error;


- (void)startRefresh;

- (void)refreshComplete:(void (^)(NSArray *datas, NSError *error))complete;

@end
