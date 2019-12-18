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
#import "DZUserNetTool.h"
#import "DZUserDataModel.h"
#import "CenterUserInfoView.h"
#import "DZUserTableView.h"

@interface DZOtherUserController ()

@property (nonatomic ,copy) NSString *authorid;
@property (nonatomic, strong) CenterUserInfoView *userInfoView;
@property (nonatomic, strong) DZUserDataModel *otherModel;
@property (nonatomic, strong) DZUserTableView *otherListView;  //!< 属性注释

@end

@implementation DZOtherUserController

- (instancetype)initWithAuthor:(NSString *)authorid
{
    authorid = checkNull(authorid);
    self = [super init];
    if (self) {
        self.authorid = authorid;
    }
    return authorid.length ? self : nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细资料";
    [self.view addSubview:self.otherListView];
    [self initData];
    [self downLoadData];
    [self configAction];
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl] PushToSettingViewController];
}

- (void)initData {
    self.otherModel = [[DZUserDataModel alloc] initWithType:JTCenterTypeOther];
}

-(void)downLoadData{
    [self initData];
    
    KWEAKSELF
    [self.HUD showLoadingMessag:@"获取信息" toView:self.view];
    [DZUserNetTool DZ_UserProfileFromServer:NO Uid:self.authorid userBlock:^(DZUserVarModel *UserVarModel, NSString *errorStr) {
        [weakSelf.HUD hide];
        [weakSelf.otherListView.mj_header endRefreshing];
        [self.HUD hideAnimated:YES];
        if (errorStr.length) {
            [DZMobileCtrl showAlertInfo:errorStr];
        }else{
            [weakSelf reloadUserInfo:UserVarModel];
        }
    }];
}



-(void)reloadUserInfo:(DZUserVarModel *)VarModel{
    [self.otherModel updateModel:VarModel];
    
    [self.otherListView updateUserTableView:self.otherModel];
    
    [self.userInfoView updateInfoHeader:VarModel.space.username title:VarModel.space.group.grouptitle icon:VarModel.member_avatar];
    
}


-(void)configAction{
    
    KWEAKSELF;
    self.otherListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf initData];
        [weakSelf downLoadData];
    }];
    
    self.otherListView.CellTapAction = ^(TextIconModel *cellModel) {
        if (cellModel.cellAction == cell_Thread){
            [[DZMobileCtrl sharedCtrl] PushToUserThreadController:weakSelf.authorid];
        }else if (cellModel.cellAction == cell_reply){
            [[DZMobileCtrl sharedCtrl] PushToUserPostReplyController:weakSelf.authorid];
        }else if (cellModel.cellAction == cell_Logout){
            [weakSelf isSureAddFriend];
        }
    };
    
}

- (void)isSureAddFriend {
    
    DLog(@"先判断一下是否是好友");
    
    return;
    [UIAlertController alertTitle:@"提示" message:@"您确认添加他为好友？" controller:self doneText:@"确定" cancelText:@"取消" doneHandle:^{
        [self addFriend];
    } cancelHandle:nil];
}

- (void)addFriend {
    if (self.otherModel.spaceModel.uid) {
        [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
            [self.HUD showLoadingMessag:@"正在请求" toView:self.view];
            NSDictionary *dic = @{@"uid":checkNull(self.otherModel.spaceModel.uid),@"type":@"1"};
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

-(DZUserTableView *)otherListView{
    if (_otherListView == nil) {
        _otherListView = [[DZUserTableView alloc] initWithFrame:KView_OutNavi_Bounds];
        self.userInfoView = [[CenterUserInfoView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 140)];
        _otherListView.tableHeaderView = self.userInfoView;
        _otherListView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    }
    return _otherListView;
}

@end
