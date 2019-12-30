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
#import "DZVerticalButton.h"
#import "MYCenterHeader.h"
#import "DZUserNetTool.h"
#import "DZUserDataModel.h"
#import "DZImagePickerView.h"
#import "UIImage+Limit.h"
#import "DZUserTableView.h"

@interface DZUserController ()

@property (nonatomic, strong) MYCenterHeader *myHeader;
@property (nonatomic, strong) DZUserDataModel *centerModel;
@property (nonatomic, strong) DZImagePickerView *pickerView;    // 相机相册
@property (nonatomic, strong) DZUserTableView *UserListView;    // 相机相册

@end

@implementation DZUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUserNavi];
    [self tooBarAction];
    [self downLoadData];
    
    [self addNotify];
}

#pragma mark - 设置导航栏
-(void)setUserNavi{
    self.title = @"我的";
    [self.view addSubview:self.UserListView];
    self.UserListView.tableHeaderView = self.myHeader;
    [self configNaviBar:@"" type:NaviItemText Direction:NaviDirectionLeft];
    [self configNaviBar:@"setting" type:NaviItemImage Direction:NaviDirectionRight];
}

- (void)rightBarBtnClick {
    
    [[DZMobileCtrl sharedCtrl] PushToSettingViewController];
}

- (void)notiReloadData {
    [self.UserListView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self downLoadData];
}

- (void)initData {
    self.centerModel = [[DZUserDataModel alloc] initWithType:JTCenterTypeMy];
}

-(void)downLoadData {
    
    [self initData];
    [self.HUD showLoadingMessag:@"拉取信息" toView:self.view];
    KWEAKSELF
    NSString *userId = [DZMobileCtrl sharedCtrl].Global.member_uid;
    [DZUserNetTool DZ_UserProfileFromServer:YES Uid:userId userBlock:^(DZUserVarModel *UserVarModel, NSString *errorStr) {
        [weakSelf.HUD hide];
        if (errorStr.length) {
            [weakSelf UserSignout];
            [DZMobileCtrl showAlertInfo:errorStr];
        }else{
            [weakSelf reloadUserController:UserVarModel];
        }
        [weakSelf.UserListView.mj_header endRefreshing];
    }];
}

-(void)reloadUserController:(DZUserVarModel *)VarModel{
    [self.centerModel updateModel:VarModel];
    
    [[DZMobileCtrl sharedCtrl] updateGlobalModel:VarModel];
    
    [self.UserListView updateUserTableView:self.centerModel];
    
    [self.myHeader updateHeader:VarModel.space.username title:VarModel.space.group.grouptitle icon:VarModel.member_avatar];
}

// toobar 点击事件
- (void)tooBarAction {
    KWEAKSELF;
    self.myHeader.tooView.toolItemClickBlock = ^(DZVerticalButton *sender, NSInteger index, NSString *name) {
        
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
    
    // cell 点击事件
    self.UserListView.CellTapAction = ^(TextIconModel *cellModel) {
        if (cellModel.cellAction == cell_Thread){
            DLog(@"我的帖子");
        }else if (cellModel.cellAction == cell_reply){
            DLog(@"我的回复");
        }else if (cellModel.cellAction == cell_Logout){
            [weakSelf signoutAction];
        }
    };
    
    // 下拉刷新
    self.UserListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf downLoadData];
    }];
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
    
    KWEAKSELF
    [self.HUD showLoadingMessag:@"上传中" toView:self.view];
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
    [self.UserListView reloadData];
    [self transtoUserLogin];
    [[NSNotificationCenter defaultCenter] postNotificationName:DZ_CollectionInfoRefresh_Notify object:nil];
}

- (void)transtoUserLogin {
    [[DZMobileCtrl sharedCtrl] PresentLoginController];
}


-(BOOL)DZ_hideTabBarWhenPushed{
    return NO;
}
- (void)addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiReloadData) name:DZ_RefreshUserCenter_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserSignout) name:DZ_UserSigOut_Notify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiReloadData) name:DZ_DomainUrlChange_Notify object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (DZImagePickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[DZImagePickerView alloc] init];
        _pickerView.navigationController = self.navigationController;
    }
    return _pickerView;
}

-(DZUserTableView *)UserListView{
    if (_UserListView == nil) {
        _UserListView = [[DZUserTableView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KScreenHeight - KNavi_ContainStatusBar_Height - KTabbar_Height)];
        _UserListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    }
    return _UserListView;
}

-(MYCenterHeader *)myHeader{
    if (_myHeader == nil) {
        _myHeader = [[MYCenterHeader alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 220)];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modifyAvatar)];
        [_myHeader.userInfoView.headView addGestureRecognizer:tapGes];
    }
    return _myHeader;
}





@end
