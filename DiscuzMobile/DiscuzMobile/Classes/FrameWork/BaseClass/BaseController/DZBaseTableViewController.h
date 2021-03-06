//
//  DZBaseTableViewController.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/5.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZBaseViewController.h"
#import "DZBaseTableView.h"

@interface DZBaseTableViewController : DZBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) DZBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
@property (nonatomic, strong) NSMutableDictionary *cellHeightDict;

@property (nonatomic, assign) NSInteger page;

/**
 空数据的时候显示 这里要设置dataSourceArr.count = 0的时候
 */
- (void)emptyShow;

@end
