//
//  DZBaseTableViewController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/5.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableViewController.h"

@implementation DZBaseTableViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    // 点击菜单栏刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:DZ_TabbarRefresh_Notify object:nil];
    // 无图模式
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadImage) name:DZ_ImageOrNot_Notify object:nil];
    // 点击导航栏到顶部
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarTappedAction:) name:DZ_StatusBarTap_Notify object:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaul5CellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaul5CellId"];
    }
    return cell;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - public
- (void)emptyShow {
    
    if (self.dataSourceArr.count > 0) {
        [self.tableView.mj_footer setHidden:NO];
        self.emptyView.hidden = YES;
    } else {
        self.emptyView.hidden = NO;
        if (!self.tableView.tableHeaderView) {
            self.emptyView.frame = self.tableView.bounds;
        }else{
            CGFloat headerHeight = CGRectGetHeight(self.tableView.tableHeaderView.frame);
            self.emptyView.frame = CGRectMake(self.tableView.left, self.tableView.top + headerHeight, self.tableView.width, self.tableView.height - headerHeight);
        }
        if (!self.emptyView.isOnView) {
            [self.tableView addSubview:self.emptyView];
            self.emptyView.isOnView = YES;
        }
        [self.tableView.mj_footer setHidden:YES];
    }
}

#pragma mark - private
// 刷新
- (void)refresh {
    if ([self.view hu_intersectsWithAnotherView:nil]) {
        [self.tableView.mj_header beginRefreshing];
    }
}

// 点击状态栏到顶部
- (void)statusBarTappedAction:(NSNotification*)notification {
    if ([self.view hu_intersectsWithAnotherView:nil]) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
// 有图无图
- (void)reloadImage {
    if (self.cellHeightDict.count > 0) {
        [self.cellHeightDict removeAllObjects];
    }
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark setter getter
- (NSMutableDictionary *)cellHeightDict {
    if (!_cellHeightDict) {
        _cellHeightDict = [NSMutableDictionary dictionary];
    }
    return _cellHeightDict;
}

- (NSMutableArray *)dataSourceArr {
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}

- (DZBaseTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[DZBaseTableView alloc] initWithFrame:KView_OutNavi_Bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _tableView;
}

@end
