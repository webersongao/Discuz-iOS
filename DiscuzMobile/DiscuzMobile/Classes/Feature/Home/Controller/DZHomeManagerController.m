//
//  DZHomeManagerController.m
//  DiscuzMobile
//
//  Created by HB on 17/1/13.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZHomeManagerController.h"
#import "DZSettingController.h"
#import "RNCachingURLProtocol.h"
#import "ForumCell.h"
#import "DZHomeNetTool.h"
#import "DZLoginModule.h"
#import "DZHomeListCell.h"
#import "ThreadListModel.h"
#import "DZForumInfoModel.h"
#import "DZBaseUrlController.h"
#import "DZSlideShowScrollView.h"

#import "RootForumCell.h"

@interface DZHomeManagerController ()

@property (nonatomic, strong) NSMutableArray <DZForumInfoModel *>*offenSource;
@property (nonatomic, strong) NSMutableArray <ThreadListModel *>*hotSource;

@end


@implementation DZHomeManagerController

- (void)leftBarBtnClick {
    if (![self isLogin]) {
        return;
    }
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl]PushToSearchController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commitInit];
    [self initRequest];
    self.navigationItem.title = DZ_APPNAME;
    [self.view addSubview:self.tableView];
}


- (void)commitInit {
    [self configNaviBar:@"bar_message" type:NaviItemImage Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
    KWEAKSELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf initRequest];
    }];
}

- (void)initRequest {
//    if ([DZLoginModule isLogged]) { // 收藏版块
//        [self downLoadFavForumData];
//    } else { // 热门版块
        [self downLoadHotforumData];
//    }
}

//  下载热门版块 hotforum（常去的版块）-- 未登录时候
-(void)downLoadHotforumData {
    KWEAKSELF
    [DZHomeNetTool DZ_HomeDownLoadHotforumData:^(NSArray <DZForumInfoModel *>*array, NSError *error) {
        if (error) {
            [weakSelf showServerError:error];
        }else{
            [weakSelf setForumHotData:array];
        }
    }];
}

// 下载收藏版块（常去的版块）-- 登录时候
-(void)downLoadFavForumData{
    KWEAKSELF
    [DZHomeNetTool DZ_HomeDownLoadFavForumData:^(NSArray <DZForumInfoModel *>*array, NSError *error) {
        if (error) {
            if (error.localizedDescription) {
                [weakSelf showServerError:error];
            }else{
                [weakSelf downLoadHotforumData];
            }
        }else{
            [weakSelf setForumHotData:array];
        }
    }];
}

//  处理热门版块数据
- (void)setForumHotData:(NSArray <DZForumInfoModel *>*)dataModelArr {
    if (self.offenSource.count) {
        [self.offenSource removeAllObjects];
    }
    self.offenSource = dataModelArr.copy;
    [self.tableView reloadData];
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 90.0;
    }else {
        UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [(DZHomeListCell *)cell cellHeight];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        if (self.offenSource.count <= 2) {
            return self.offenSource.count;
        } else if (self.offenSource.count > 2) {
            return 2;
        }
        return 0;
    } else {
        return self.hotSource.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *headID = @"CellHeader";
    RootForumCell *cell = [tableView dequeueReusableCellWithIdentifier:headID];
    if (cell == nil) {
        cell = [[RootForumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headID];
    }
    
    if (section == 0) {
        cell.textLab.text = @"常去的版块";
    } else {
        cell.textLab.text = @"热帖";
    }
    
    [cell.button setHidden:YES];
    
    return cell;
}

#pragma mark: 常去版块 待定
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *OffenId = @"OffenID";
        
        ForumCell *cell = [tableView dequeueReusableCellWithIdentifier:OffenId];
        if (cell == nil) {
            cell = [[ForumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OffenId];
        }
        DZForumInfoModel * infoModel;
        
        if (self.offenSource.count > indexPath.row) {
            infoModel = self.offenSource[indexPath.row];
        }
        
        if (infoModel != nil) {
            [cell setInfo:infoModel];
        }
        return cell;
        
    } else {
        
        static  NSString  * CellIdentiferId = @"HomeCellCellID";
        DZHomeListCell  * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
        if (cell == nil) {
            cell = [[DZHomeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentiferId];
        }
        
        ThreadListModel *model = [self.hotSource objectAtIndex:indexPath.row];
        cell.info = model;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        DZForumInfoModel *infoModel = self.offenSource[indexPath.row];
        [[DZMobileCtrl sharedCtrl] PushToForumListController:infoModel.fid];
    } else {
        ThreadListModel *model = self.hotSource[indexPath.row];
        [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:model.tid];
    }
}

#pragma mark - getter
- (NSMutableArray <DZForumInfoModel *>*)offenSource {
    if (!_offenSource) {
        _offenSource = [NSMutableArray array];
    }
    return _offenSource;
}

- (NSMutableArray <ThreadListModel *>*)hotSource {
    if (!_hotSource) {
        _hotSource = [NSMutableArray array];
    }
    return _hotSource;
}

@end





