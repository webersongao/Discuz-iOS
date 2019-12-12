//
//  MyFriendViewController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/5.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "MyFriendViewController.h"
#import "DZOtherUserController.h"
#import "FriendCell.h"
#import "DZUserNetTool.h"

@implementation MyFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downLoadData];
    self.title = @"我的好友";
    KWEAKSELF;
    self.tableView.frame = KView_OutNavi_Bounds;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf refreshData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf refreshData];
    }];
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
}

- (void)refreshData {
    [self downLoadData];
}


#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellId = @"FriendId";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell == nil) {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    
    NSDictionary *dic;
    if ([DataCheck isValidArray:self.dataSourceArr]) {
        dic = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    [cell.headV sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"noavatar_small"] options:SDWebImageRetryFailed];
    cell.nameLab.text = [dic objectForKey:@"username"];
    cell.sendBtn.tag = indexPath.row;
    [cell.sendBtn addTarget:self action:@selector(sendMessageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)sendMessageBtnClick:(UIButton *)btn {
    NSDictionary *dic;
    if ([DataCheck isValidArray:self.dataSourceArr]) {
        dic = [self.dataSourceArr objectAtIndex:btn.tag];
    }
    
    [[DZMobileCtrl sharedCtrl] PushToMsgChatController:[dic stringForKey:@"uid"] name:[dic stringForKey:@"username"]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic;
    if ([DataCheck isValidArray:self.dataSourceArr]) {
        dic = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    DZOtherUserController * ovc = [[DZOtherUserController alloc] init];
    ovc.authorid = [dic objectForKey:@"uid"];
    [self showViewController:ovc sender:nil];
    
}

- (void)downLoadData {
    
    
    [DZUserNetTool DZ_FriendListWithUid:nil Page:self.page completion:^(DZFriendVarModel *varModel, NSError *error) {
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
                self.title = [NSString stringWithFormat:@"我的好友（%ld）",varModel.count];
            }
            
            [self emptyShow];
            
            [self.tableView reloadData];
        }else{
            [self showServerError:error];
            [self.HUD hideAnimated:YES];
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

@end

