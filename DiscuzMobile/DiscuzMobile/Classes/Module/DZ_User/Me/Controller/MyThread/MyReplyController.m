//
//  MyReplyController.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/12.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "MyReplyController.h"
#import "OtherUserPostReplyCell.h"
#import "ReplyCell.h"
#import "SubjectCell.h"
#import "DZUserNetTool.h"
#import "MsgReplyModel.h"

@interface MyReplyController ()

@property (nonatomic, assign) NSInteger listcount;
@property (nonatomic, assign) NSInteger tpp;
@property (nonatomic, strong) NSMutableArray *replyArr;

@end

@implementation MyReplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dz_NavigationItem.title = @"我的回复";
    
    _listcount = 0;
    _tpp = 0;
    
    [self downLoadData];
    [self.view addSubview:self.tableView];
    KWEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf addData];
    }];
    self.tableView.mj_footer.hidden = YES;
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
}

- (void)refreshData {
    self.page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [self downLoadData];
}

- (void)addData {
    self.page ++;
    [self downLoadData];
}

#pragma mark - tableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellId = @"CellId";
    
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[SubjectCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
    }
    DZThreeadItemModel *itemModel = self.dataSourceArr[indexPath.row];
    
    [cell updateSubjectCell:itemModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DZThreeadItemModel *itemModel = self.dataSourceArr[indexPath.row];
    [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:itemModel.tid];
}

- (void)downLoadData {
    
    [DZUserNetTool DZ_MyThreadOrReplyListWithType:@"reply" Page:self.page completion:^(DZMyThreadVarModel *varModel, NSError *error) {
        [self.HUD hide];
        if (varModel) {
            [self.tableView.mj_header endRefreshing];
            if (varModel.data.count) {
                if (self.page == 1) {
                    self.dataSourceArr = varModel.data.mutableCopy;
                } else {
                    [self.dataSourceArr addObjectsFromArray:varModel.data];
                }
                if (varModel.data.count < varModel.perpage) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [self emptyShow];
            [self.tableView reloadData];
        }else{
            [self emptyShow];
            [self showServerError:error];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

- (void)clearData {
    if (self.dataSourceArr.count > 0) {
        [self.dataSourceArr removeAllObjects];
    }
    if (self.replyArr.count > 0) {
        [self.replyArr removeAllObjects];
    }
    self.cellHeightDict = [NSMutableDictionary dictionary];
}

- (NSMutableArray *)replyArr {
    if (!_replyArr) {
        _replyArr = [NSMutableArray array];
    }
    return _replyArr;
}

@end
