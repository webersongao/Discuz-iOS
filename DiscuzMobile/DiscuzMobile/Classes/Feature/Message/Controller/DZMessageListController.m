//
//  DZMessageListController.m
//  DiscuzMobile
//
//  Created by HB on 2017/7/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZMessageListController.h"
#import "DZUserMsgBoxTabController.h"

#import "DZPMListCell.h"
#import "PmTypeModel.h"
#import "MessageNoticeCenter.h"

@interface DZMessageListController ()

@end

@implementation DZMessageListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的消息";
    [self.view addSubview:self.tableView];
    self.dataSourceArr = @[@"我的消息",@"我的帖子",@"坛友互动",@"系统提醒",@"管理工作"].mutableCopy;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DZPMListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Pmlis8GtCell"];
    if (cell == nil) {
        cell = [[DZPMListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Pmlis8GtCell"];
    }
    
    NSString *title = self.dataSourceArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.titleLab.attributedText = [self cellGetAttributeStr:title andNew:[[MessageNoticeCenter shared].noticeDic objectForKey:@"newpm"]];
    } else {
        
        cell.titleLab.attributedText = [self cellGetAttributeStr:title andNew:[[MessageNoticeCenter shared].noticeDic objectForKey:@"newmypost"]];
    }
    
    cell.iconV.image = [UIImage imageTintColorWithName:[NSString stringWithFormat:@"pm_%ld",indexPath.row] andImageSuperView:cell.iconV];
    
    return cell;
}

- (NSMutableAttributedString *)cellGetAttributeStr:(NSString *)title andNew:(NSString *)new {
    
    NSMutableAttributedString *describe = [[NSMutableAttributedString alloc] initWithString:title];
    if ([DataCheck isValidString:new]) {
        if ([new integerValue] > 0) {
            describe = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@(%@)",title,new]];
            NSRange todayRange = NSMakeRange(describe.length - new.length - 2, new.length + 2);
            [describe addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:todayRange];
        }
    }
    
    return describe;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellThinHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PmTypeModel *model = nil;
    if (indexPath.row < 3) {
        DZUserMsgBoxTabController *topBabVc = [[DZUserMsgBoxTabController alloc] init];
        switch (indexPath.row) {
            case 0: {
                model = [[PmTypeModel alloc] initWithTitle:@"我的消息" andModule:@"mypm" anFilter:@"privatepm" andView:nil andType:nil];
                [[DZMobileCtrl sharedCtrl] PushToMyMsgSubListController:self.dataSourceArr[indexPath.row] Model:model];
                return;
            }
                break;
            case 1:
                topBabVc.pmType = pm_mythread;
                break;
            case 2:
                topBabVc.pmType = pm_interactive;
                break;
            default:
                break;
        }
        topBabVc.title = self.dataSourceArr[indexPath.row];
        [self showViewController:topBabVc sender:nil];
    } else {
        
        if (indexPath.row == 3) {
            model = [[PmTypeModel alloc] initWithTitle:@"系统提醒" andModule:@"mynotelist" anFilter:@"" andView:@"system" andType:@""];
        } else {
             model = [[PmTypeModel alloc] initWithTitle:@"管理工作" andModule:@"mynotelist" anFilter:@"" andView:@"manage" andType:@""];
        }
        [[DZMobileCtrl sharedCtrl] PushToMyMsgSubListController:self.dataSourceArr[indexPath.row] Model:model];
    }
}



@end









