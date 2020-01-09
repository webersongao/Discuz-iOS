//
//  CollectionThreadController.m
//  DiscuzMobile
//
//  Created by HB on 17/1/20.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "CollectionThreadController.h"
#import "CollectionViewCell.h"
#import "DZUserNetTool.h"

@interface CollectionThreadController ()

@end

@implementation CollectionThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downLoadMyFavThread];
    KWEAKSELF;
    self.tableView.mj_header = [DZRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf.tableView.mj_footer resetNoMoreData];
        [weakSelf downLoadMyFavThread];
    }];
    
    self.tableView.mj_footer = [DZRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf downLoadMyFavThread];
    }];
    [self.view addSubview:self.tableView];
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
}

// 收藏帖子
-(void)downLoadMyFavThread{
    
    
    [DZUserNetTool DZ_FavoriteThreadListWithPage:self.page completion:^(DZFavThreadVarModel *varModel, NSError *error) {
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
            
            if (varModel.count) {
                if (self.dataSourceArr.count >= varModel.count) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [self emptyShow];
            [self.tableView reloadData];
        }else{
            [self emptyShow];
            [self mj_endRefreshing];
        }
    }];
    
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
    
    return 75.0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellId = @"CellIdtow";
    CollectionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
    }
    
    
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:indexPath.row];
    if ([DataCheck isValidDict:dic]) {
        [cell setData:dic];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *tidStr = [[self.dataSourceArr objectAtIndex:indexPath.row]objectForKey:@"id"];
    [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:tidStr];
}




@end
