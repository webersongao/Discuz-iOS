//
//  DZOtherUserPostReplyController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/8/24.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZOtherUserPostReplyController.h"
#import "OtherUserPostReplyCell.h"
#import "MsgReplyModel.h"
#import "ReplyCell.h"

@interface DZOtherUserPostReplyController()

@property (nonatomic,assign) NSInteger listcount;
@property (nonatomic,assign) NSInteger tpp;
@property (nonatomic, strong) NSMutableArray *replyArr;

@end


@implementation DZOtherUserPostReplyController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.dz_NavigationItem.title=@"他的回复";
    
    _listcount = 0;
    _tpp = 0;
    
    [self downLoadData];
    [self.view addSubview:self.tableView];
    KWEAKSELF;
    self.tableView.mj_header = [DZRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    
    self.tableView.mj_footer = [DZRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf moreUserPostReplyData];
    }];
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
}

- (void)refreshData {
    [self.tableView.mj_footer resetNoMoreData];
    self.page = 1;
    [self downLoadData];
}

- (void)moreUserPostReplyData {
    self.page ++;
    [self downLoadData];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    return 85.0;
    if (!self.cellHeightDict[indexPath]) {
        self.cellHeightDict[indexPath] = @([self heightForRowAtIndexPath:indexPath tableView:tableView]);
    }
    return [self.cellHeightDict[indexPath] floatValue];
    
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    return [(ReplyCell *)cell cellHeight];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return self.dataSourceArr.count;
    return self.replyArr.count;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Repl4yCell"];
    if (cell == nil) {
        cell = [[ReplyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Repl4yCell"];
    }
    MsgReplyModel *model = self.replyArr[indexPath.row];
    [cell setInfo:model];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataSourceArr.count > 0) {
        MsgReplyModel *model = self.replyArr[indexPath.row];
        [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:model.tid];
    }
}
- (void)downLoadData {
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *dic = @{@"uid":self.uidstr,@"page":[NSString stringWithFormat:@"%ld",self.page]};
        request.urlString = DZ_Url_UserPost;
        request.parameters = dic;
    } success:^(id responseObject, JTLoadType type) {
        DLog(@"userpostreplyVariables=%@",responseObject);
        [self.HUD hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([DataCheck isValidArray:[[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist"]]) {
            if (self.page == 1) {
                
                [self clearData];
                [self.tableView.mj_header endRefreshing];
                if ([DataCheck isValidArray:[[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist"]]) {
                    self.dataSourceArr = [NSMutableArray arrayWithArray:[[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist" ]];
                    [self analysisData:[[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist" ]];
                }
                [self emptyShow];
            } else {
                if ([DataCheck isValidArray:[[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist"]]) {
                    NSArray *arr = [[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist" ];
                    [self.dataSourceArr addObjectsFromArray:arr];
                    [self analysisData:arr];
                }
            }
        }
        if ([DataCheck isValidString:[[responseObject objectForKey:@"Variables"] objectForKey:@"tpp"]]) {
            _tpp = [[[responseObject objectForKey:@"Variables"] objectForKey:@"tpp"] integerValue];
        }
        if ([DataCheck isValidString:[[responseObject objectForKey:@"Variables"] objectForKey:@"listcount"]]) {
            _listcount = [[[responseObject objectForKey:@"Variables"] objectForKey:@"listcount"] integerValue];
        }
        
        if (_listcount < _tpp) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self emptyShow];
        [self.tableView reloadData];
        
    } failed:^(NSError *error) {
        DLog(@"%@",error);
        [self emptyShow];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self showServerError:error];
        [self.HUD hideAnimated:YES];
    }];
    
}

- (void)analysisData:(NSArray *)dataArr {
    
    for (NSDictionary *dic in dataArr) {
        
        if ([DataCheck isValidArray:[dic objectForKey:@"reply"]]) {
            
            NSArray *arr = [dic objectForKey:@"reply"];
            
            for (NSDictionary *replyDic in arr) {
                
                MsgReplyModel *reply = [MsgReplyModel modelWithJSON:replyDic];
                [self.replyArr addObject:reply];
            }
        }
    }
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
