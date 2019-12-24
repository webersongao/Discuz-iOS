//
//  DZHomeThreadListBaseCtrl.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/10.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZHomeThreadListBaseCtrl.h"
#import "DZHomeVarModel.h"
#import "DZHomeNetTool.h"
#import "DZThreadListCell+Manager.h"
#import "DZThreadListModel+Display.h"

@interface DZHomeThreadListBaseCtrl ()

@end

@implementation DZHomeThreadListBaseCtrl

#pragma mark - lifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstRequest:) name:DZ_CONTAINERQUEST_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:DZ_DomainUrlChange_Notify object:nil];
    
    [self requestLocalCache];
}

- (void)initTableView {
    
    [self.tableView registerClass:[DZThreadListCell class] forCellReuseIdentifier:[DZThreadListCell getReuseId]];
    KWEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
        if ([weakSelf.view hu_intersectsWithAnotherView:nil]) {
        }
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf downLoadHomeThreadData:self.page andLoadType:JTRequestTypeRefresh];
    }];
    self.tableView.height = KView_OutNavi_Bounds.size.height - kHomeSegmentHeight;
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
    ((MJRefreshAutoFooter *)self.tableView.mj_footer).triggerAutomaticallyRefreshPercent = -10;
}

#pragma mark - Request

- (void)firstRequest:(NSNotification *)notification {
    if (![self.view hu_intersectsWithAnotherView:nil]) {
        return;
    }
    
    NSDictionary *userInfo = notification.userInfo;
    if ([DataCheck isValidDict:userInfo]) {
        NSInteger index = [[userInfo objectForKey:@"selectIndex"] integerValue];
        if (!self.dataSourceArr.count && index != 0) {
            [self requestLocalCache];
        }
    }
}

- (void)requestLocalCache {
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
    [self downLoadHomeThreadData:self.page andLoadType:JTRequestTypeCache];
    
}

- (void)refreshData {
    self.page =1;
    [self.tableView.mj_footer resetNoMoreData];
    [self downLoadHomeThreadData:self.page andLoadType:JTRequestTypeRefresh];
}

#pragma mark - 数据下载
- (void)downLoadHomeThreadData:(NSInteger)page andLoadType:(JTLoadType)type {
    
    [DZHomeNetTool DZ_HomeDownLoadThreadList:page Url:self.urlString LoadType:type completion:^(DZHomeVarModel *discover, NSError *error) {
        [self.HUD hide];
        if (discover) {
            [self.tableView.mj_header endRefreshing];
            if (self.page == 0) { // 刷新列表 刷新的时候移除数据源
                [self clearDatasource];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
            
            if (discover.data.count) {
                [self.dataSourceArr addObjectsFromArray:discover.data];
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.tableView reloadData];
        }else{
            [self showServerError:error];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

- (void)clearDatasource {
    if (self.cellHeightDict.count > 0) {
        [self.cellHeightDict removeAllObjects];
    }
    if (self.dataSourceArr.count > 0) {
        [self.dataSourceArr removeAllObjects];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DZThreadListModel *listModel = self.dataSourceArr[indexPath.row];
    DZThreadListCell * listCell = [self.tableView dequeueReusableCellWithIdentifier:[DZThreadListCell getReuseId] forIndexPath:indexPath];
    
    [listCell updateThreadCell:[listModel dealSpecialThread] isTop:NO];
    
    return listCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.cellHeightDict[indexPath]) {
        self.cellHeightDict[indexPath] = @([self heightForRowAtIndexPath:indexPath tableView:tableView]);
    }
    return [self.cellHeightDict[indexPath] floatValue];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    DZThreadListModel *listModel = self.dataSourceArr[indexPath.row];
    return listModel.listLayout.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DZThreadListModel *listModel = self.dataSourceArr[indexPath.row];
    [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:listModel.tid];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.didScrollAction) {
        self.didScrollAction(scrollView);
    }
}

#pragma mark - Action
- (void)toOtherCenter:(UITapGestureRecognizer *)sender {
    
    [[DZMobileCtrl sharedCtrl] PushToOtherUserController:checkInteger(sender.view.tag)];
}

@end
