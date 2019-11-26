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
    
    // 点击导航栏到顶部
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarTappedAction:) name:DZ_STATUSBARTAP_Notify object:nil];
    // 点击菜单栏刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:DZ_TABBARREFRESH_Notify object:nil];
    // 无图模式
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadImage) name:DZ_IMAGEORNOT_Notify object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateTableViewToRemoveNaviBar{
    self.tableView.frame = CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KScreenHeight - KNavi_ContainStatusBar_Height);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
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
        self.emptyView.frame = self.tableView.frame;
        if (self.tableView.tableHeaderView != nil) {
            CGFloat height = CGRectGetHeight(self.tableView.tableHeaderView.frame);
            if (height > 0) {
                CGRect tempRect = self.tableView.frame;
                self.emptyView.frame = CGRectMake(tempRect.origin.x, tempRect.origin.y + height, CGRectGetWidth(tempRect), CGRectGetHeight(tempRect) - height);
            }
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
        _tableView = [[DZBaseTableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _tableView;
}

@end
