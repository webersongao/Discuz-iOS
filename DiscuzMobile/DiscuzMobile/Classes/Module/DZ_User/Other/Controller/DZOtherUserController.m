//
//  DZOtherUserController.m
//  DiscuzMobile
//
//  Created by HB on 17/1/20.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZOtherUserController.h"
#import "UIAlertController+Extension.h"
#import "CenterToolView.h"
#import "VerticalImageTextView.h"
#import "DZUserNetTool.h"
#import "TextIconModel.h"
#import "CenterManageModel.h"
#import "CenterCell.h"
#import "CenterUserInfoView.h"
#import "AllOneButtonCell.h"


@interface DZOtherUserController ()

@property (nonatomic, strong) CenterUserInfoView *userInfoView;
@property (nonatomic, strong) CenterManageModel *otherModel;

@end

@implementation DZOtherUserController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详细资料";
    
    if (![DataCheck isValidString:self.authorid]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self.view addSubview:self.tableView];
    self.userInfoView = [[CenterUserInfoView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 140)];
    self.tableView.tableHeaderView = self.userInfoView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    
    [self initData];
    
    [self downLoadData];
    KWEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf initData];
        [weakSelf downLoadData];
    }];
}

- (void)rightBarBtnClick {
      [[DZMobileCtrl sharedCtrl] PushToSettingViewController];
}

- (void)notiReloadData {
    [self downLoadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)initData {
    self.otherModel = [[CenterManageModel alloc] initWithType:JTCenterTypeOther];
}

-(void)downLoadData{
    [self initData];
    
    KWEAKSELF
    [DZUserNetTool DZ_UserProfileFromServer:NO Uid:self.authorid userBlock:^(DZUserVarModel *UserVarModel, NSString *errorStr) {
        [weakSelf.HUD hide];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.HUD showLoadingMessag:@"获取信息" toView:self.view];
        
        if (errorStr.length) {
            [DZMobileCtrl showAlertInfo:errorStr];
        }else{
            weakSelf.otherModel.isOther = YES;
            weakSelf.otherModel.userVarModel = UserVarModel;
            [weakSelf.userInfoView.headView sd_setImageWithURL:[NSURL URLWithString:UserVarModel.space.avatar] placeholderImage:[UIImage imageNamed:@"noavatar_small"] options:SDWebImageRetryFailed];
            weakSelf.userInfoView.nameLab.text = UserVarModel.space.username;
            [weakSelf.userInfoView setIdentityText:UserVarModel.space.group.grouptitle];
            
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 60;
    }
    return 50.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.otherModel.useArr.count;
    } else if (section == 1){
        return self.otherModel.manageArr.count;
    } else if (section == 2) {
        return self.otherModel.infoArr.count;
    } else if (self.otherModel.userVarModel) {
        if (![self.authorid isEqualToString:[DZLoginModule getLoggedUid]] && !self.otherModel.userVarModel.space.isfriend) {
            return 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"CenterID";
    static NSString *OneID = @"AddFriend";
    
    if (indexPath.section != 3) {
        CenterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            cell = [[CenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            
        }
        if (indexPath.section == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        TextIconModel *model;
        if (indexPath.section == 0) {
            model = self.otherModel.useArr[indexPath.row];
        }
        if (indexPath.section == 1) {
            model = self.otherModel.manageArr[indexPath.row];
            
        } else if (indexPath.section == 2) {
            model = self.otherModel.infoArr[indexPath.row];
        }
        [cell setData:model];
        return cell;
    } else {
        AllOneButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:OneID];
        if (cell == nil) {
            KWEAKSELF;
            cell = [[AllOneButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OneID];
            cell.actionBlock = ^(UIButton *sender) {
                [weakSelf isSure:sender];
            };
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [cell.ActionBtn setTitle:@"加好友" forState:UIControlStateNormal];
        }
        return cell;
    }
}

- (void)isSure:(UIButton *)sender {
    
    [UIAlertController alertTitle:@"提示" message:@"您确认添加他为好友？" controller:self doneText:@"确定" cancelText:@"取消" doneHandle:^{
        [self addFriend];
    } cancelHandle:nil];
}

- (void)addFriend {
    if (self.otherModel.userVarModel.space.uid) {
        [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
            [self.HUD showLoadingMessag:@"正在请求" toView:self.view];
            NSDictionary *dic = @{@"uid":checkNull(self.otherModel.userVarModel.space.uid),@"type":@"1"};
            request.urlString = DZ_Url_AddFriend;
            request.parameters = dic;
        } success:^(id responseObject, JTLoadType type) {
            [self.HUD hide];
            if ([[[responseObject objectForKey:@"Variables"] objectForKey:@"code"] isEqualToString:@"1"]) {
                [MBProgressHUD showInfo:@"操作成功，等待好友确认"];
            } else {
                NSString *message = [[responseObject objectForKey:@"Variables"] objectForKey:@"message"];
                [MBProgressHUD showInfo:message];
            }
            
        } failed:^(NSError *error) {
            [self.HUD hide];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:           //他的话题
                {
                    [[DZMobileCtrl sharedCtrl] PushToUserThreadController:self.authorid];
                }
                    break;
                case 1:          //他的回复
                {
                   [[DZMobileCtrl sharedCtrl] PushToUserPostReplyController:self.authorid];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 1:
            
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}

@end
