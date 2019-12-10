//
//  DZViewPollPotionController.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/8/24.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZViewPollPotionController.h"
#import "ViewPollpotionCell.h"
#import "DZPostNetTool.h"
#import "UIAlertController+Extension.h"

@interface DZViewPollPotionController()<ViewPollpotionCellDelegate>

@property (strong,nonatomic)UITableView *tableview;
@property (strong,nonatomic)NSArray *array;
@property (strong,nonatomic)NSArray *arrayImage;

@end

@implementation DZViewPollPotionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downLoadData];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellID= @"viewReplyCellID";
    ViewPollpotionCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[ViewPollpotionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate=self;
    NSDictionary * dic = [self.dataSourceArr objectAtIndex:indexPath.row];
    CGRect rect = cell.frame;
    [cell setdata:dic];
    rect.size.height = [cell cellheigh];
    cell.frame = rect;
    return cell;
}

- (void)ViewPollpotionCellClick:(ViewPollpotionCell *)cell {
    
    if (![self isLogin]) {
        return;
    }
    [[DZMobileCtrl sharedCtrl] PushToMsgSendController:cell.nameLabel.text];
}

- (void)downLoadData {
    [self.HUD showLoadingMessag:@"正在加载" toView:self.view];
    [[DZPostNetTool sharedTool] DZ_DownloadVoteOptionsDetail:self.tid pollid:self.pollid success:^(DZVoteResModel *voteModel) {
        [self.HUD hide];
        if (voteModel) {
            if (!voteModel.Message.isAuthorized) {
                [UIAlertController alertTitle:nil message:voteModel.Message.messagestr controller:self doneText:@"知道了" cancelText:nil doneHandle:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } cancelHandle:nil];
                return;
            }
            self.dataSourceArr = [NSMutableArray arrayWithArray:voteModel.Variables.viewvote.voterlist];
            [self.tableView reloadData];
            [self emptyShow];
        }else{
            [self emptyShow];
        }
    }];
}

@end
