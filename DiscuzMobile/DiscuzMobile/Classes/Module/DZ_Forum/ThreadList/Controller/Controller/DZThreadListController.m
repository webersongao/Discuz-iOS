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
#import "ThreadListCell.h"
#import "DZThreadTopCell.h"
#import "VerifyThreadRemindView.h"

@interface DZThreadListController ()
@property (nonatomic, strong) VerifyThreadRemindView *verifyThreadRemindView;
@property (nonatomic ,strong) DZForumModel *forumModel;
@property (nonatomic ,strong) DZThreadVarModel *VarModel;  //  数据
@property (nonatomic, assign) BOOL isRequest;
@property (nonatomic, assign) DZ_ListType listType;  //!< 属性注释
@property (nonatomic, assign) NSInteger notThisFidCount;
@property (nonatomic, strong) NSMutableArray *topThreadArray;
@property (nonatomic, strong) NSMutableArray *commonThreadArray;
@end

@implementation DZThreadListController

- (instancetype)initWithType:(DZ_ListType)listType
{
    self = [super init];
    if (self) {
        self.listType = listType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    self.notThisFidCount = 0;
    
    [self inittableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstRequest:) name:DZ_ThreadListFirstReload_Notify object:nil];
    
    if (self.order == 0) {
        self.isRequest = YES;
        [self loadCache];
    }
}

- (void)showVerifyRemind {
    self.tableView.tableHeaderView = self.verifyThreadRemindView;
    //    self.verifyThreadRemindView.textLabel.text = [NSString stringWithFormat:@"您有 %@ 个主题等待审核，点击查看",self.forumInfo.threadmodcount];
}

- (void)hidVerifyRemind {
    self.tableView.tableHeaderView = nil;
}

- (void)firstRequest:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if ([DataCheck isValidDictionary:userInfo]) {
        NSInteger index = [[userInfo objectForKey:@"selectIndex"] integerValue];
        if (index == self.order && !self.isRequest) {
            self.isRequest = YES;
            [self loadCache];
        }
    }
}

-(void)inittableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (self.forumModel) {
            NSInteger threadsCount = self.forumModel.threadcount + self.notThisFidCount;
            if (threadsCount > self.dataSourceArr.count) {
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

- (void)refreshData {
    self.page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [self downLoadListData:self.page andLoadType:JTRequestTypeRefresh];
}

- (void)loadCache { // 读取缓存
    
    if (self.listType == DZ_ListAll) {
        [self downLoadListData:self.page andLoadType:JTRequestTypeCache];
        [self.HUD showLoadingMessag:@"正在刷新" toView:self.view];
        if ([DZApiRequest isCache:DZ_Url_ForumTlist andParameters:@{@"fid":[NSString stringWithFormat:@"%@",_fid],@"page":[NSString stringWithFormat:@"%ld",(long)self.page]}]) {
            [self downLoadListData:self.page andLoadType:JTRequestTypeRefresh];
        }
    } else {
        [self.HUD showLoadingMessag:@"正在刷新" toView:self.view];
        [self downLoadListData:self.page andLoadType:JTRequestTypeRefresh];
    }
}


#pragma mark - 数据下载
- (void)downLoadListData:(NSInteger)page andLoadType:(JTLoadType)loadType {
    
    [DZThreadNetTool DZ_DownloadForumListWithType:loadType fid:self.fid page:page listType:self.listType completion:^(DZThreadResModel *threadResModel, BOOL isCache, NSError *error) {
        [self.HUD hide];
        if (threadResModel) {
            [self.tableView.mj_header endRefreshing];
            if (!threadResModel.Message.isAuthorized) {
                [UIAlertController alertTitle:nil message:threadResModel.Message.messagestr controller:self doneText:@"知道了" cancelText:nil doneHandle:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } cancelHandle:nil];
                [self.HUD hideAnimated:YES];
                return ;
            }
            
            self.VarModel = threadResModel.Variables;
            self.forumModel = threadResModel.Variables.forum;
            
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
            
            NSString *threadmodcount = self.forumModel.threadmodcount;
            if ([DataCheck isValidString:threadmodcount] && [threadmodcount integerValue] > 0) {
                if (page == 1 && (isCache == NO || loadType == JTRequestTypeRefresh)) {
                    self.verifyThreadRemindView.textLabel.text = [NSString stringWithFormat:@"您有 %@ 个主题等待审核，点击查看",threadmodcount];
                    [self showVerifyRemind];
                }
            } else {
                [self hidVerifyRemind];
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
            NSInteger threadsCount = self.forumModel.threadcount + self.notThisFidCount;
            if (threadsCount <= self.dataSourceArr.count) {
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

- (void)clearDatasource {
    
    self.notThisFidCount = 0;
    if (self.dataSourceArr.count > 0) {
        [self.dataSourceArr removeAllObjects];
    }
    if (self.cellHeightDict.count > 0) {
        [self.cellHeightDict removeAllObjects];
    }
    if (self.topThreadArray.count > 0) {
        [self.topThreadArray removeAllObjects];
        [self.commonThreadArray removeAllObjects];
    }
}

- (void)anylyeThreadListData:(DZThreadResModel *)responseObject {
    
    self.VarModel = responseObject.Variables;
    
    [self.VarModel updateVarModel:self.fid andPage:self.page handle:^(NSArray *topArr, NSArray *commonArr, NSArray *allArr, NSInteger notFourmCount) {
        if (self.page == 1) {
            self.notThisFidCount = notFourmCount;
            self.topThreadArray = [NSMutableArray arrayWithArray:topArr];
            self.commonThreadArray = [NSMutableArray arrayWithArray:commonArr];
            self.dataSourceArr = [NSMutableArray arrayWithArray:allArr];
        } else {
            if ([DataCheck isValidArray:commonArr]) {
                DZThreadListModel *model1 = commonArr.firstObject;
                DZThreadListModel *model2 = self.dataSourceArr.firstObject;
                if ([model1.tid isEqualToString:model2.tid]) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    return;
                }
                [self.commonThreadArray addObjectsFromArray:commonArr];
            }
            if ([DataCheck isValidArray:allArr]) {
                [self.dataSourceArr addObjectsFromArray:allArr];
            }
        }
    }];
    
}

- (void)sendVariablesToMixcontroller {
    if (self.listType == DZ_ListAll) {
        if (self.sendListBlock) {
            self.sendListBlock(self.VarModel);
        }
    }
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.topThreadArray.count > 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.cellHeightDict[indexPath]) {
        self.cellHeightDict[indexPath] = @([self heightForRowAtIndexPath:indexPath tableView:tableView]);
    }
    return [self.cellHeightDict[indexPath] floatValue];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (self.topThreadArray.count > 0) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0 || indexPath.row == self.topThreadArray.count + 1) {
                return 5;
            }
            return [(DZThreadTopCell *)cell cellHeight];
        } else {
            return [(ThreadListCell *)cell cellHeight];
        }
    } else {
        return [(ThreadListCell *)cell cellHeight];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.topThreadArray.count > 0) {
        if (section == 0) {
            return self.topThreadArray.count + 2; // 为了置顶帖那里显示更协调
        }
        return self.commonThreadArray.count;
    }
    
    return self.dataSourceArr.count;
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
    if (self.topThreadArray.count > 0) {
        if (indexPath.section == 0) {
            static NSString * CellId = @"ForumTopThreadCellId";
            DZThreadTopCell  * cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            if (cell == nil) {
                cell = [[DZThreadTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
            }
            if (indexPath.row == 0 || indexPath.row == self.topThreadArray.count + 1) {
                [cell updateTopCellWithModel:nil];
            } else {
                DZThreadListModel *listModel = self.topThreadArray[indexPath.row - 1];
                [cell updateTopCellWithModel:listModel];
            }
            return cell;
        } else {
            DZThreadListModel *listModel = self.commonThreadArray[indexPath.row];
            return [self configListCell:listModel];
        }
    } else {
        DZThreadListModel *listModel = self.dataSourceArr[indexPath.row];
        return [self configListCell:listModel];
    }
}

- (ThreadListCell *)configListCell:(DZThreadListModel *)listModel {
    static NSString * CellId = @"ThreadListId";
    ThreadListCell * cell = [self.tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[ThreadListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    cell.listInfo = listModel;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toOtherCenter:)];
    cell.headV.tag = [listModel.authorid integerValue];
    [cell.headV addGestureRecognizer:tapGes];
    return cell;
}

- (void)toOtherCenter:(UITapGestureRecognizer *)sender {
    
    if (![self isLogin]) {
        return;
    }
    
    [[DZMobileCtrl sharedCtrl] PushToOtherUserController:checkInteger(sender.view.tag)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DZThreadListModel *listModel;
    if (self.topThreadArray.count > 0) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0 || indexPath.row == self.topThreadArray.count + 1) {
                return;
            }
            listModel = self.topThreadArray[indexPath.row - 1];
        } else {
            listModel = self.commonThreadArray[indexPath.row];
        }
    } else {
        listModel = self.dataSourceArr[indexPath.row];
    }
    
    [self pushThreadDetail:listModel];
}

- (void)pushThreadDetail:(DZThreadListModel *)listModel {
    
    [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:listModel.tid];
}

- (void)ToDZMySubjectController {
    DZMySubjectController *mysubjectVc = [[DZMySubjectController alloc] init];
    [self showViewController:mysubjectVc sender:nil];
}

- (NSMutableArray *)topThreadArray {
    if (!_topThreadArray) {
        _topThreadArray = [NSMutableArray array];
    }
    return _topThreadArray;
}

- (NSMutableArray *)commonThreadArray {
    if (!_commonThreadArray) {
        _commonThreadArray = [NSMutableArray array];
    }
    return _commonThreadArray;
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



