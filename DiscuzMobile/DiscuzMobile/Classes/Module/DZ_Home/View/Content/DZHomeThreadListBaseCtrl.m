//
//  DZHomeThreadListBaseCtrl.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/10.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZHomeThreadListBaseCtrl.h"
#import "DZHomeVarModel.h"
#import "DZThreadListCell.h"
#import "DZHomeNetTool.h"
#import "DZThreadListModel+Display.h"

@interface DZHomeThreadListBaseCtrl ()
@property (nonatomic, copy) NSString *urlString;
@end

@implementation DZHomeThreadListBaseCtrl

#pragma mark - lifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    if (self.listType == HomeListBest) {
        self.urlString = DZ_Url_DigestAll;
    } else if (self.listType == HomeListNewest) {
        self.urlString = DZ_Url_NewAll;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(firstRequest:)
                                                 name:DZ_CONTAINERQUEST_Notify
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData)
                                                 name:DZ_DomainUrlChange_Notify
                                               object:nil];
    
    [self cacheRequest];
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
            [self cacheRequest];
        }
    }
}

- (void)cacheRequest {
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
            if (self.page == 1) { // 刷新列表 刷新的时候移除数据源
                [self clearDatasource];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
            
            if ([DataCheck isValidArray:discover.data]) {
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
    DZThreadListCell * cell = [self.tableView dequeueReusableCellWithIdentifier:[DZThreadListCell getReuseId]];
    
    [cell updateThreadCell:[listModel dealSpecialThread]];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toOtherCenter:)];
    cell.headV.tag = [listModel.authorid integerValue];
    [cell.headV addGestureRecognizer:tapGes];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.cellHeightDict[indexPath]) {
        self.cellHeightDict[indexPath] = @([self heightForRowAtIndexPath:indexPath tableView:tableView]);
    }
    return [self.cellHeightDict[indexPath] floatValue];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    DZThreadListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    DZThreadListModel *listModel = self.dataSourceArr[indexPath.row];
    return [cell caculateCellHeight:listModel];
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
