//
//  DZUserController.m
//  DiscuzMobile
//
//  Created by HB on 17/1/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZUserController.h"
#import "UIAlertController+Extension.h"
#import "CenterToolView.h"
#import "VerticalImageTextView.h"
#import "MYCenterHeader.h"
#import "LogoutCell.h"
#import "CenterCell.h"
#import "DZUserNetTool.h"

#import "TextIconModel.h"
#import "CenterUserInfoView.h"
#import "CenterManageModel.h"

#import "DZImagePickerView.h"
#import "UIImage+Limit.h"

@interface DZUserController ()

@property (nonatomic, strong) MYCenterHeader *myHeader;
@property (nonatomic, strong) CenterManageModel *centerModel;
@property (nonatomic, strong) DZImagePickerView *pickerView;    // 相机相册

@end

@implementation DZUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUserNavi];
    
    // 135 + 85
    [self updateTableViewToRemoveNaviBar];
    self.myHeader = [[MYCenterHeader alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 220)];
    self.tableView.tableHeaderView = self.myHeader;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modifyAvatar)];
    [self.myHeader.userInfoView.headView addGestureRecognizer:tapGes];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    [self.view addSubview:self.tableView];
    [self tooBarAction];
    
    [self.HUD showLoadingMessag:@"拉取信息" toView:self.view];
    [self downLoadData];
    
    KWEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf downLoadData];
    }];
    
    [self addNotify];
}

-(BOOL)hideTabBarWhenPushed{
    return NO;
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiReloadData) name:DZ_REFRESHCENTER_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserSignout) name:DZ_UserSigOut_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiReloadData) name:DZ_DomainUrlChange_Notify object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置导航栏
-(void)setUserNavi{
    self.title = @"我的";
    [self configNaviBar:@"" type:NaviItemText Direction:NaviDirectionLeft];
    [self configNaviBar:@"setting" type:NaviItemImage Direction:NaviDirectionRight];
}

- (void)rightBarBtnClick {
    
    [[DZMobileCtrl sharedCtrl] PushToSettingViewController];
}

- (void)notiReloadData {
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self downLoadData];
}

- (void)initData {
    self.centerModel = [[CenterManageModel alloc] initWithType:JTCenterTypeMy];
}

// toobar 点击事件
- (void)tooBarAction {
    KWEAKSELF;
    self.myHeader.tooView.toolItemClickBlock = ^(VerticalImageTextView *sender, NSInteger index, NSString *name) {
        
        if (![weakSelf isLogin]) {
            return;
        }
        switch (index) {
            case 0:          //我的好友
            {
                [[DZMobileCtrl sharedCtrl] PushToMyFriendViewController];
            }
                break;
            case 1:          //我的收藏
            {
                [[DZMobileCtrl sharedCtrl] PushToMyCollectionViewController];
            }
                break;
            case 2:          //我的提醒
            {
                [[DZMobileCtrl sharedCtrl] PushToMyMessageViewController];
            }
                break;
            case 3:          //我的主题
            {
                [[DZMobileCtrl sharedCtrl] PushToMyThreadListViewController];
            }
                break;
                
            default:
                break;
        }
        
    };
}

-(void)downLoadData {
    
    [self initData];
    KWEAKSELF
    NSString *userId = [DZMobileCtrl sharedCtrl].User.member_uid;
    [DZUserNetTool DZ_UserProfileFromServer:YES Uid:userId userBlock:^(DZUserVarModel *UserVarModel, NSString *errorStr) {
        [weakSelf.HUD hide];
        if (errorStr.length) {
            [weakSelf UserSignout];
            [weakSelf transtoUserLogin];
            [DZMobileCtrl showAlertInfo:errorStr];
        }else{
            weakSelf.centerModel.userVarModel = UserVarModel;
            [DZMobileCtrl sharedCtrl].User.member_avatar = UserVarModel.member_avatar;
            weakSelf.myHeader.userInfoView.nameLab.text = UserVarModel.space.username;
            [weakSelf.myHeader.userInfoView setIdentityText:UserVarModel.space.group.grouptitle];
            [weakSelf.myHeader.userInfoView.headView sd_setImageWithURL:[NSURL URLWithString:UserVarModel.member_avatar] placeholderImage:[UIImage imageNamed:@"noavatar_small"] options:SDWebImageRefreshCached];
        }
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 60;
    }
    return 50.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0){
        
        return self.centerModel.manageArr.count;
        
    } else if (section == 1) {
        
        return self.centerModel.infoArr.count;
        
    } else if (self.centerModel.userVarModel) {
        
        return 1;
        
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"CenterID";
    static NSString *LogoutID = @"LogoutID";
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        CenterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (cell == nil) {
            cell = [[CenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        TextIconModel *model;
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            model = self.centerModel.manageArr[indexPath.row];
        } else if (indexPath.section == 1) {
            if (self.centerModel.infoArr.count > indexPath.row) {
                model = self.centerModel.infoArr[indexPath.row];
            }
        }
        [cell setData:model];
        return cell;
        
    } else {
        LogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:LogoutID];
        if (cell == nil) {
            cell = [[LogoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LogoutID];
        }
        cell.lab.text = @"退出";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [[DZMobileCtrl sharedCtrl] ShowBindControllerFromVC:self];
        }
        
        if (indexPath.row == 1) {
            return;
            [[DZMobileCtrl sharedCtrl] ShowResetPwdControllerFromVC:self];
        }
        
        if (indexPath.row == 2) {
            [[DZMobileCtrl sharedCtrl] ShowFootMarkControllerFromVC:self];
        }
    }
    
    if (indexPath.section == 2) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSString *message = @"您确定退出？退出将不能体验全部功能。";
        NSString *donetip = @"退出";
        
        [UIAlertController alertTitle:@"提示" message:message controller:self doneText:donetip cancelText:@"取消" doneHandle:^{
            [self UserSignout];
        } cancelHandle:nil];
    }
}

- (void)signoutAction {
    NSString *message = @"您确定退出？退出将不能体验全部功能。";
    NSString *donetip = @"确定";
    [UIAlertController alertTitle:@"提示" message:message controller:self doneText:donetip cancelText:@"取消" doneHandle:^{
        [self UserSignout];
    } cancelHandle:nil];
}

- (void)modifyAvatar {
    KWEAKSELF;
    self.pickerView.finishPickingBlock = ^(UIImage *image) {
        [weakSelf uploadImage:image];
    };
    [self.pickerView openSheet];
}

- (void)uploadImage:(UIImage *)image {
    
    [self.HUD showLoadingMessag:@"上传中" toView:self.view];
    KWEAKSELF
    [DZUserNetTool DZ_UserUpdateAvatarToServer:image progress:^(double Progress, NSError *error) {
    } completion:^(BOOL boolState) {
        if (boolState) {
            [weakSelf.HUD hide];
            [MBProgressHUD showInfo:@"上传成功"];
            weakSelf.myHeader.userInfoView.headView.image = image;
        }else{
            [weakSelf.HUD hide];
            [MBProgressHUD showInfo:@"上传失败"];
        }
    }];
}

- (void)UserSignout {
    [DZLoginModule signout];
    [self initData];
    [self.tableView reloadData];
    [self transtoUserLogin];
    [[NSNotificationCenter defaultCenter] postNotificationName:COLLECTIONFORUMREFRESH object:nil];
}

- (void)transtoUserLogin {
    [[DZMobileCtrl sharedCtrl] PresentLoginController:self];
}

- (DZImagePickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[DZImagePickerView alloc] init];
        _pickerView.navigationController = self.navigationController;
    }
    return _pickerView;
}

@end
