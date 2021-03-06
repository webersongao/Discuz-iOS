//
//  DZMsgSubListController.m
//  DiscuzMobile
//
//  Created by HB on 2017/7/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZMsgSubListController.h"
#import "MessageListModel.h"
#import "MessageCell.h"
#import "SystemNoteCell.h"
#import "MsglistCell.h"
#import "DZMsgNetTool.h"

@interface DZMsgSubListController ()
@end

@implementation DZMsgSubListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.typeModel.module isEqualToString:@"mypm"]) {
        [self configNaviBar:@"发消息" type:NaviItemText Direction:NaviDirectionRight];
    }
    [self loadMsgSubListData];
    [self.view addSubview:self.tableView];
    KWEAKSELF;
    self.tableView.mj_header = [DZRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf loadMsgSubListData];
    }];
    
    self.tableView.mj_footer = [DZRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf loadMsgSubListData];
    }];
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
}

-(void)rightBarBtnClick{
    [[DZMobileCtrl sharedCtrl] PushToMsgSendController:nil];
}

- (void)loadMsgSubListData {
    NSMutableArray *parameter = [NSMutableArray array];
    NSString *urlString = @"";
    if ([self.typeModel.module isEqualToString:@"mypm"]) { // 我的消息
        
        parameter = @{@"page":[NSString stringWithFormat:@"%ld",self.page],
                      @"filter":self.typeModel.filter}.mutableCopy;
        urlString = DZ_Url_MsgList;
    } else if ([self.typeModel.view isEqualToString:@"mypost"]) {// 我的帖子
        parameter = @{@"page":[NSString stringWithFormat:@"%ld",self.page],
                      @"type":self.typeModel.type}.mutableCopy;
        urlString = DZ_Url_ThreadMsgList;
        
    } else if ([self.typeModel.view isEqualToString:@"interactive"]) {// 坛友互动
        parameter = @{@"page":[NSString stringWithFormat:@"%ld",self.page],
                      @"type":self.typeModel.type}.mutableCopy;
        urlString = DZ_Url_InteractiveMsgList;
        
    } else if ([self.typeModel.view isEqualToString:@"system"] || [self.typeModel.view isEqualToString:@"manage"]) {// 系统提醒 | 管理工作
        
        parameter = @{@"page":[NSString stringWithFormat:@"%ld",self.page],
                      @"view":self.typeModel.view}.mutableCopy;
        urlString = DZ_Url_SystemMsgList;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = urlString;
        request.methodType = JTMethodTypePOST;
        request.parameters = parameter;
    } success:^(id responseObject, JTLoadType type) {
        [self anylyeMsgData:responseObject];
    } failed:^(NSError *error) {
        [self errorDo:error];
    }];
}

- (void)anylyeMsgData:(id)responseObject {
    [self.HUD hideAnimated:YES];
    [self mj_endRefreshing];
    
    NSArray *arr = [[responseObject objectForKey:@"Variables"] objectForKey:@"list"];
    if ([DataCheck isValidArray:arr]) {
        
        if (self.page == 1) {
            self.dataSourceArr = [NSMutableArray array];
        }
        
        for (NSDictionary *dic in arr) {
            MessageListModel *model = [MessageListModel modelWithJSON:dic];
            [self.dataSourceArr addObject:model];
        }
    }
    
    if ([DataCheck isValidString:[[responseObject objectForKey:@"Variables"] objectForKey:@"count"]]) {
        NSInteger count = [[[responseObject objectForKey:@"Variables"] objectForKey:@"count"] integerValue];
        if (self.dataSourceArr.count >= count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    
    [self emptyShow];
    [self.tableView reloadData];
}

- (void)mj_endRefreshing {
    if (self.page == 1) {
        [self.tableView.mj_header endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)errorDo:(NSError *)error {
    [self.HUD hideAnimated:YES];
    [self emptyShow];
    [self showServerError:error];
    [self mj_endRefreshing];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.typeModel.module isEqualToString:@"mypm"]) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        return [(MessageCell *)cell cellHeight];
        //        return 70.0;
     }else {
        UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [(MsglistCell *)cell cellHeight];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageListModel *model = self.dataSourceArr[indexPath.row];
    
    if ([self.typeModel.module isEqualToString:@"mypm"]) {
        
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Messag5eCell"];
        if (cell == nil) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Messag5eCell"];
        }
        
        [cell setData:model];
        return cell;
     }else {
        
        MsglistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Msglist3dCell"];
        if (cell == nil) {
            cell = [[MsglistCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Msglist3dCell"];
        }
        
        [cell setData:model];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageListModel *model = self.dataSourceArr[indexPath.row];
    
    if ([DataCheck isValidString:self.typeModel.filter] && [self.typeModel.filter isEqualToString:@"privatepm"]) {
        [[DZMobileCtrl sharedCtrl] PushToMsgChatController:model.touid name:model.tousername];
    }
    
    if ([DataCheck isValidString:self.typeModel.view] && [self.typeModel.view isEqualToString:@"mypost"]) {
        if (model.notevar) {
            [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:model.notevar.tid];
        } else {
            NSArray *arr = [model.note componentsSeparatedByString:@"tid="];
            if (arr.count >= 2) {
                NSString *containTid = arr[1];
                NSString *tid = [containTid componentsSeparatedByString:@"\" "][0];
                if ([tid isNum:tid]) {
                    [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:tid];
                }
            }
        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.typeModel.module isEqualToString:@"mypm"]) {
        
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    if ([self.typeModel.module isEqualToString:@"mypm"]) {
        
        [self.tableView setEditing:YES animated:animated];
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self deletePmessage:indexPath];
    }
}


- (void)deletePmessage:(NSIndexPath *)indexPath {
    
    MessageListModel *model = self.dataSourceArr[indexPath.row];
    
    [DZMsgNetTool DZ_DeletePMMessage:model.touid completion:^(DZBaseResModel *resModel, NSError *error) {
        if (resModel) {
            if (resModel.Message && resModel.Message.isSuccessed){
                [self.dataSourceArr removeObjectAtIndex:indexPath.row];
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
                [self.tableView endUpdates];
            } else {
                [MBProgressHUD showInfo:@"删除失败"];
            }
        }else{
            [self showServerError:error];
        }
    }];
}

@end
