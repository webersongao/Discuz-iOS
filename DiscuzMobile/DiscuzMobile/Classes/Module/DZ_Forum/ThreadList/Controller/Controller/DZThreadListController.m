//
//  DZThreadListController.m
//  DiscuzMobile
//
//  Created by HB on 2017/5/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZThreadListController.h"
#import "DZMySubjectController.h"
#import "UIAlertController+Extension.h"
#import "DZThreadListModel.h"
#import "DZThreadListModel+Display.h"
#import "DZShareCenter.h"
#import "AsyncAppendency.h"
#import "DZThreadListCell.h"
#import "DZThreadTopCell.h"
#import "VerifyThreadRemindView.h"

@interface DZThreadListController ()

@property (nonatomic, copy) NSString *fid;
@property (nonatomic, assign) NSInteger order;

@property (nonatomic, strong) VerifyThreadRemindView *verifyThreadRemindView;
@property (nonatomic ,strong) DZThreadVarModel *VarModel;  //  数据
@property (nonatomic, assign) DZ_ListType listType;  //!< 属性注释
@property (nonatomic, assign) NSInteger notThisFidCount;
@property (nonatomic, strong) NSMutableArray *allArray;  //!< 属性注释
@end

@implementation DZThreadListController

- (instancetype)initWithType:(DZ_ListType)listType fid:(NSString *)fid order:(NSInteger)order
{
    self = [super init];
    if (self) {
        self.fid = fid;
        self.order = order;
        self.listType = listType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    [self inittableView];
    self.notThisFidCount = 0;
    [self loadThreadDataCache];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstThreadListRequest:) name:DZ_ThreadListFirstReload_Notify object:nil];
}


-(void)inittableView {
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.VarModel.forum) {
            NSInteger threadsCount = self.VarModel.forum.threadcount + self.notThisFidCount;
            if (threadsCount > self.allArray.count) {
                self.page ++;
                [self downLoadListData:self.page andLoadType:JTRequestTypeRefresh];
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    self.tableView.mj_footer.hidden = YES;
    ((MJRefreshAutoFooter *)self.tableView.mj_footer).triggerAutomaticallyRefreshPercent = -20;
}

- (void)refreshThreadListData {
    self.page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [self downLoadListData:self.page andLoadType:JTRequestTypeRefresh];
}

- (void)loadThreadDataCache { // 读取缓存
    [self.HUD showLoadingMessag:@"正在刷新" toView:self.view];
    if (self.listType == DZ_ListAll) {
        [self downLoadListData:self.page andLoadType:JTRequestTypeCache];
    } else {
        [self downLoadListData:self.page andLoadType:JTRequestTypeRefresh];
    }
}


#pragma mark - 数据下载
- (void)downLoadListData:(NSInteger)page andLoadType:(JTLoadType)loadType {
    
    [DZThreadNetTool DZ_DownloadForumListWithType:loadType fid:self.fid page:page listType:self.listType completion:^(DZThreadResModel *threadResModel, BOOL isCache, NSError *error) {
        [self.HUD hide];
        if (threadResModel) {
            [self.tableView.mj_header endRefreshing];
            if (threadResModel.Message && !threadResModel.Message.isAuthorized) {
                [UIAlertController alertTitle:nil message:threadResModel.Message.messagestr controller:self doneText:@"知道了" cancelText:nil doneHandle:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } cancelHandle:nil];
                [self.HUD hideAnimated:YES];
                return ;
            }
            
            self.VarModel = threadResModel.Variables;
            
            if (self.page == 1) {
                [self sendVariablesToMixcontroller];
            }
            if (!isCache) {
                if (page == 1) {
                    if (self.endRefreshBlock) {
                        self.endRefreshBlock();
                    }
                }
            } else if (loadType == JTRequestTypeRefresh) {
                if (page == 1) {
                    if (self.endRefreshBlock) {
                        self.endRefreshBlock();
                    }
                }
            }
            
            if (page == 1 && (isCache == NO || loadType == JTRequestTypeRefresh)) {
                [self showVerifyRemind:self.VarModel.forum.threadmodcount];
            }
            
            if (self.page == 1) { // 刷新列表
                // 刷新的时候移除数据源
                [self clearDatasource];
                [self anylyeThreadListData:threadResModel];
                [self emptyShow];
            } else {
                [self.tableView.mj_footer endRefreshing];
                [self anylyeThreadListData:threadResModel];
            }
            NSInteger threadsCount = self.VarModel.forum.threadcount + self.notThisFidCount;
            if (threadsCount <= self.allArray.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        }else{
            if (self.endRefreshBlock) {
                self.endRefreshBlock();
            }
            [self emptyShow];
            [self showServerError:error];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}


- (void)showVerifyRemind:(NSString *)modCount {
    if (!modCount.length) {
        self.tableView.tableHeaderView = nil;
    }else{
        self.tableView.tableHeaderView = self.verifyThreadRemindView;
        self.verifyThreadRemindView.textLabel.text = [NSString stringWithFormat:@"您有 %@ 个主题等待审核，点击查看",modCount];
    }
}

- (void)clearDatasource {
    self.notThisFidCount = 0;
    [self.allArray removeAllObjects];;
    [self.dataSourceArr removeAllObjects];
    [self.cellHeightDict removeAllObjects];
}

- (void)firstThreadListRequest:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if ([DataCheck isValidDict:userInfo]) {
        NSInteger index = [[userInfo objectForKey:@"selectIndex"] integerValue];
        if (index == self.order && !self.dataSourceArr.count) {
            [self loadThreadDataCache];
        }
    }
}

- (void)anylyeThreadListData:(DZThreadResModel *)responseObject {
    
    self.VarModel = responseObject.Variables;
    
    [self.VarModel updateVarModel:self.fid andPage:self.page handle:^(NSArray *topArr, NSArray *commonArr, NSArray *allArr, NSInteger notFourmCount) {
        if (self.page == 1) {
            self.notThisFidCount = notFourmCount;
            [self.dataSourceArr addObject:[NSArray arrayWithArray:topArr]];
            [self.dataSourceArr addObject:[NSArray arrayWithArray:commonArr]];
            self.allArray = [NSMutableArray arrayWithArray:allArr];
        } else {
            if (commonArr.count) {
                DZThreadListModel *model1 = commonArr.firstObject;
                NSMutableArray *commonListArr = [NSMutableArray arrayWithArray:self.dataSourceArr.lastObject];
                DZThreadListModel *model2 = commonListArr.lastObject;
                if ([model1.tid isEqualToString:model2.tid]) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    return;
                }
                [commonListArr addObjectsFromArray:commonArr];
                [self.dataSourceArr replaceObjectAtIndex:1 withObject:commonListArr];
            }
            if (allArr.count) {
                [self.allArray addObjectsFromArray:allArr];
            }
        }
    }];
}

- (void)sendVariablesToMixcontroller {
    if (self.listType == DZ_ListAll) {
        if (self.dataBlockWhenAll) {
            self.dataBlockWhenAll(self.VarModel);
        }
    }
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.cellHeightDict[indexPath]) {
        self.cellHeightDict[indexPath] = @([self heightForRowAtIndexPath:indexPath tableView:tableView]);
    }
    return [self.cellHeightDict[indexPath] floatValue];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

    if ([cell isKindOfClass:[DZThreadTopCell class]]) {
        return [(DZThreadTopCell *)cell cellHeight];
    }else{
        return [(DZThreadListCell *)cell cellHeight];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *sectionArray = self.dataSourceArr[section];
    return sectionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 5;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

#pragma mark- 判断是不是置顶帖子  displayorder  3，2，1 置顶  0 正常 -1 回收站  -2 审核中  -3 审核忽略  -4草稿
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //判断是不是置顶帖子  displayorder  3，2，1 置顶  0 正常  -1 回收站  -2 审核中  -3 审核忽略  -4草稿
    NSArray *sectionArr = self.dataSourceArr[indexPath.section];
    
    if (indexPath.section == 0) {
        DZThreadTopCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"ForumTopThreadCellId"];
        if (cell == nil) {
            cell = [[DZThreadTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ForumTopThreadCellId"];
        }
        [cell updateTopCellWithModel:sectionArr[indexPath.row]];
        return cell;
    }
    
    DZThreadListModel *listModel = sectionArr[indexPath.row];
    return [self configListCell:listModel];
}

- (DZThreadListCell *)configListCell:(DZThreadListModel *)listModel {
    
    DZThreadListCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"ThreadListId"];
    if (cell == nil) {
        cell = [[DZThreadListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThreadListId"];
    }
    
    [cell updateThreadCell:listModel];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toOtherCenter:)];
    cell.headV.tag = [listModel.authorid integerValue];
    [cell.headV addGestureRecognizer:tapGes];
    return cell;
}

- (void)toOtherCenter:(UITapGestureRecognizer *)sender {
    
    [[DZMobileCtrl sharedCtrl] PushToOtherUserController:checkInteger(sender.view.tag)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DZThreadListModel *listModel = self.dataSourceArr[indexPath.section][indexPath.row];
    
    [self pushThreadDetail:listModel];
}

- (void)pushThreadDetail:(DZThreadListModel *)listModel {
    
    [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:listModel.tid];
}

- (void)ToDZMySubjectController {
    DZMySubjectController *mysubjectVc = [[DZMySubjectController alloc] init];
    [self showViewController:mysubjectVc sender:nil];
}

- (VerifyThreadRemindView *)verifyThreadRemindView {
    if (!_verifyThreadRemindView) {
        _verifyThreadRemindView = [[VerifyThreadRemindView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
        KWEAKSELF;
        _verifyThreadRemindView.clickRemindBlock = ^{
            [weakSelf ToDZMySubjectController];
        };
    }
    return _verifyThreadRemindView;
}





@end



