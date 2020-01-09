//
//  DZViewPollPotionNumController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/8/24.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZViewPollPotionNumController.h"
#import "DZPostNetTool.h"

@interface DZViewPollPotionNumController()

@end

@implementation DZViewPollPotionNumController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.dz_NavigationItem.title = @"查看投票参与人";
    [self downLoadData];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellID= @"PostReplyCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[DZBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic = self.dataSourceArr[indexPath.row];

    cell.textLabel.text=[NSString stringWithFormat:@"选择第%ld项的人",indexPath.row+1];
    cell.textLabel.font=KFont(15);
    cell.detailTextLabel.text = [dic stringForKey:@"votes"];
    cell.detailTextLabel.font = KFont(14);
    cell.detailTextLabel.textColor = K_Color_Theme;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *pollidNumber= [[self.dataSourceArr objectAtIndex:indexPath.row] objectForKey:@"polloptionid"];
    NSString * tid =[[self.dataSourceArr objectAtIndex:indexPath.row] objectForKey:@"tid"];

    [[DZMobileCtrl sharedCtrl] PushToMyPollPotionController:pollidNumber tid:tid index:(indexPath.row+1)];
}

- (void)downLoadData {
    
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
    [[DZPostNetTool sharedTool] DZ_DownloadVoteOptionsDetail:self.tid pollid:nil success:^(DZVoteResModel *voteModel) {
       [self.HUD hide];
        if (voteModel) {
            self.dataSourceArr = [NSMutableArray arrayWithArray:voteModel.Variables.viewvote.polloptions];
            [self.tableView reloadData];
        }
    }];
}

@end
