//
//  CollectionForumController.m
//  DiscuzMobile
//
//  Created by HB on 17/1/20.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "CollectionForumController.h"
#import "UIAlertController+Extension.h"
#import "DZUserNetTool.h"
#import "CollectionForumCell.h"
#import "DZForumTool.h"

@interface CollectionForumController ()

@end

@implementation CollectionForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
    [self downLoadFavForumData];
    
    KWEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.tableView.mj_footer resetNoMoreData];
        weakSelf.page = 1;
        [weakSelf downLoadFavForumData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf downLoadFavForumData];
    }];
    [self.view addSubview:self.tableView];
    self.tableView.mj_footer.hidden = YES;
}


- (void)mj_endRefreshing {
    if (self.page == 1) {
        [self.tableView.mj_header endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CollectForum = @"CollectForum";
    CollectionForumCell *forumCell = [tableView dequeueReusableCellWithIdentifier:CollectForum];
    if (forumCell == nil) {
        forumCell = [[CollectionForumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CollectForum];
    }
    forumCell.cancelBtn.tag = indexPath.row;
    [forumCell.cancelBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *dic = [self.dataSourceArr objectAtIndex:indexPath.row];
    forumCell.textLab.text = [dic stringForKey:@"title"];
    
    if ([[dic objectForKey:@"todayposts"] integerValue] > 0) {
        [forumCell.iconV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"forumNew_l"] options:SDWebImageRetryFailed];
    } else {
        [forumCell.iconV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"forumCommon_l"] options:SDWebImageRetryFailed];
    }
    
    return forumCell;
}

- (void)collectionAction:(UIButton *)sender {
    
    [UIAlertController alertTitle:@"提示" message:@"确定删除此版块收藏？" controller:self doneText:@"确定" cancelText:@"取消" doneHandle:^{
        [self deleteCollection:sender.tag];
    } cancelHandle:nil];
}

- (void)deleteCollection:(NSInteger)index {
    
    NSString *fidStr = [[self.dataSourceArr objectAtIndex:index] objectForKey:@"id"];
    
    [DZForumTool DZ_DeleCollection:fidStr type:collectForum success:^{
        [self.dataSourceArr removeObjectAtIndex:index];
        [[NSNotificationCenter defaultCenter] postNotificationName:DZ_CollectionInfoRefresh_Notify object:nil];
        [self.tableView reloadData];
    } failure:nil];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *forumId = [[self.dataSourceArr objectAtIndex:indexPath.row]objectForKey:@"id"];
    [[DZMobileCtrl sharedCtrl] PushToForumListController:forumId];
}



-(void)downLoadFavForumData {
    
    [DZUserNetTool DZ_FavoriteForumListWithPage:self.page completion:^(DZFavForumVarModel *varModel, NSError *error) {
        [self.HUD hideAnimated:YES];
        if (varModel) {
            [self mj_endRefreshing];
            if (varModel.list.count) {
                if (self.page == 1) {
                    self.dataSourceArr = [NSMutableArray arrayWithArray:varModel.list];
                } else {
                    [self.dataSourceArr addObjectsFromArray:varModel.list];
                }
            }
            
            if (self.dataSourceArr.count >= varModel.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self emptyShow];
            [self.tableView reloadData];
        }else{
            [self.HUD hideAnimated:YES];
            [self emptyShow];
            [self mj_endRefreshing];
        }
    }];
    
}


@end
