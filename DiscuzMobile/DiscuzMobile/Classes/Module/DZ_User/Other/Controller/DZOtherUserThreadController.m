//
//  DZOtherUserThreadController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/8/24.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZOtherUserThreadController.h"
#import "OtherUserThearCell.h"

@interface DZOtherUserThreadController()

@property (nonatomic,assign) NSInteger listcount;
@property (nonatomic,assign) NSInteger tpp;

@end


@implementation DZOtherUserThreadController

-(void)viewDidLoad{

    [super viewDidLoad];
    self.dz_NavigationItem.title=@"他的主题";
    
    _listcount = 0;
    _tpp = 0;
    
    [self downLoadData];
    [self.view addSubview:self.tableView];
    KWEAKSELF;
    self.tableView.mj_header = [DZRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];

    self.tableView.mj_footer = [DZRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreUserThreadData];
    }];
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
}

- (void)refreshData {
    [self.tableView.mj_footer resetNoMoreData];
    self.page = 1;
    [self downLoadData];
}

- (void)loadMoreUserThreadData {
    self.page ++;
    [self downLoadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSourceArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OtherUserThearCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherUserThes3arCell"];
    if (cell == nil) {
        cell = [[OtherUserThearCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"OtherUserThes3arCell"];
    }
    NSDictionary *dic = [self.dataSourceArr objectAtIndex:indexPath.row];
    if ([DataCheck isValidDict:dic]) {
        [cell setData:dic];
    }
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataSourceArr.count > 0) {
        NSString * tidStr = [[self.dataSourceArr objectAtIndex:indexPath.row] objectForKey:@"tid"];
        [[DZMobileCtrl sharedCtrl] PushToThreadDetailController:tidStr];
    }
}

- (void)downLoadData {
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *dic = @{@"uid":self.uidstr,@"page":[NSString stringWithFormat:@"%ld",self.page]};
        request.urlString = DZ_Url_OtherThread;
        request.parameters = dic;
    } success:^(id responseObject, JTLoadType type) {
        
        DLog(@"userthreadVariables=%@",responseObject);
        
        [self.HUD hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([DataCheck isValidArray:[[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist"]]) {
            if (self.page == 1) {
                self.dataSourceArr = [NSMutableArray arrayWithArray:[[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist"]];
            } else {
                NSArray *arr = [[responseObject objectForKey:@"Variables"] objectForKey:@"threadlist" ];
                [self.dataSourceArr addObjectsFromArray:arr];
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
        [self emptyShow];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self showServerError:error];
        [self.HUD hideAnimated:YES];
    }];
}
@end
