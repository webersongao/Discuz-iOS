//
//  DZFastPostController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZFastPostController.h"
#import "DZPostTypeSelectView.h"
#import "DZMenuTableListView.h"
#import "DZThreadNetTool.h"
#import "DZPostNetTool.h"

@interface DZFastPostController ()<DZMenuTableViewDelagete>

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) NSArray *dataArray;  //!< 属性注释
@property (nonatomic, strong) DZForumBaseNode *indexNode;  //!< <#属性注释#>
@property (nonatomic, strong) DZBaseAuthModel *authModel;
@property (nonatomic, strong) DZMenuTableListView *menuBar;  //条件选择器
@property (nonatomic, strong) DZPostTypeSelectView *selectView;

@end

@implementation DZFastPostController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downloadPosMenuListData];
    [self configPostViewController];
    self.dz_NavigationItem.title = @"选择发帖版块";
}

-(void)configPostViewController{
    self.menuBar = [[DZMenuTableListView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KView_OutNavi_Bounds.size.height)];
    self.menuBar.delegate = self;
    [self.view addSubview:self.menuBar];
    [self.view addSubview:self.closeBtn];
    self.menuBar.backgroundColor = [UIColor whiteColor];
    [self configNaviBar:@"刷新" type:NaviItemText Direction:NaviDirectionRight];
}


// 下载数据
- (void)downloadPosMenuListData {
    
    KWEAKSELF
    [self.HUD showLoadingMessag:@"数据加载中" toView:self.view];
    [DZThreadNetTool DZ_DownloadForumCategoryData:JTRequestTypeRefresh isCache:NO completion:^(DZDiscoverModel *indexModel) {
        [self.HUD hideAnimated:YES];
        if (indexModel.catlist) {
            weakSelf.menuBar.nodeDataArray = indexModel.indexNodeArray;
        }else{
            [DZMobileCtrl showAlertError:@"获取信息失败，请稍后重试"];
        }
    }];
    
}


-(void)leftBarBtnClick{
    [self.menuBar dismissMenuListView];
    [super leftBarBtnClick];
}

-(void)rightBarBtnClick{
    [self.menuBar dismissMenuListView];
    [self downloadPosMenuListData];
}

- (void)showTypeView {
    
    if (![self isLogin]) {
        return;
    }
    if (self.selectView.typeArray.count == 0) {
        [MBProgressHUD showInfo:@"您当前无权限发帖"];
        return;
    } else if (self.selectView.typeArray.count == 1) {
        PostTypeModel *model = self.selectView.typeArray[0];
        [self switchTypeTopost:model.type];
    } else {
        [self.selectView show];
    }
}

#pragma mark   /********************* DZMenuTableViewDelagete 代理方法 *************************/

-(void)MenuTableView:(DZMenuTableListView *)view didSelectCell:(DZForumBaseNode *)cellNode{
    self.indexNode = cellNode;
    [self CheckNodeUserPostAuthWithNode:cellNode];
}


-(void)CheckNodeUserPostAuthWithNode:(DZForumBaseNode *)indexNode{
    [self.HUD showLoadingMessag:@"验证发帖权限" toView:self.view];
    [[DZPostNetTool sharedTool] DZ_CheckUserPostAuth:indexNode.fidStr success:^(DZBaseAuthModel *authModel) {
        [self.HUD hide];
        if (authModel) {
            self.authModel = authModel;
            if ([authModel isUserLogin]) {
                if (authModel.group) { // 能发的帖子类型处理
                    NSString *allowspecialonly = authModel.forum.allowspecialonly;
                    [self.selectView setPostType:checkInteger(authModel.group.allowpostpoll)
                                        activity:checkInteger(authModel.group.allowpostactivity)
                                          debate:checkInteger(authModel.group.allowpostdebate)
                                allowspecialonly:allowspecialonly
                                       allowpost:authModel.allowperm.allowpost];
                    [self showTypeView];
                } else {
                    [MBProgressHUD showInfo:@"暂无发帖权限"];
                }
            }else{
                [MBProgressHUD showInfo:@"暂无发帖权限"];
            }
        }else{
            [MBProgressHUD showInfo:@"暂无发帖权限"];
        }
    }];
}

#pragma mark - 点击去往发帖页
- (void)switchTypeTopost:(PostType)type {
    [self dismissViewControllerAnimated:YES completion:^{
        [[DZMobileCtrl sharedCtrl] PushToThreadPostController:self.indexNode.fidStr thread:self.authModel type:type];
    }];
}

- (void)closeBtnClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:DZ_configSelectedIndex_Notify object:nil];
    [self dz_PopCurrentViewController];
}


#pragma mark   /********************* 初始化 *************************/

-(DZPostTypeSelectView *)selectView{
    if (!_selectView) {
        _selectView = [[DZPostTypeSelectView alloc] init];
        KWEAKSELF;
        _selectView.typeBlock = ^(PostType type) {
            [weakSelf.selectView close];
            [weakSelf switchTypeTopost:type];
        };
    }
    return _selectView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"closeTz"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.frame = CGRectMake((KScreenWidth - kToolBarHeight)/2.f, KScreenHeight - KTabbar_Height + 5, kToolBarHeight, kToolBarHeight);
    }
    return _closeBtn;
}



@end
