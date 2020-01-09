//
//  MyTopicViewController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/5.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZMySubjectController.h"
#import "SubjectCell.h"
#import "DZUserNetTool.h"

@interface DZMySubjectController ()

@end

@implementation DZMySubjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dz_NavigationItem.title = @"我的主题";
    
    [self downLoadData];
    [self.view addSubview:self.tableView];
    KWEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf addMySubjectData];
    }];
}

- (void)reloadData {
    self.page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [self downLoadData];
}

- (void)addMySubjectData {
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
    
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCelsal"];
    if (cell == nil) {
        cell = [[SubjectCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SubjectCelsal"];
    }
    DZThreeadItemModel * itemModel = [self.dataSourceArr objectAtIndex:indexPath.row];
    
    [cell updateSubjectCell:itemModel];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * tidStr = [[self.dataSourceArr objectAtIndex:indexPath.row] stringForKey:@"tid"];
    
    [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:tidStr];
    
}

-(void)downLoadData {
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
    [DZUserNetTool DZ_MyThreadOrReplyListWithType:@"thread" Page:self.page completion:^(DZMyThreadVarModel *varModel, NSError *error) {
        [self.HUD hide];
        if (varModel) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            if (varModel.data.count) {
                if (self.page == 1) {
                    self.dataSourceArr = [NSMutableArray arrayWithArray:varModel.data];
                    if (self.dataSourceArr.count < varModel.perpage) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                } else {
                    [self.dataSourceArr addObjectsFromArray:varModel.data];
                    if (varModel.data.count < varModel.perpage) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }
            }
            [self emptyShow];
            [self.tableView reloadData];
        }else{
            [self showServerError:error];
            [self emptyShow];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

@end
