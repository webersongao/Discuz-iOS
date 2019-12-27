//
//  DZGaoPostViewController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGaoPostViewController.h"
#import "DZMenuTableListView.h"
#import "DZThreadNetTool.h"


@interface DZGaoPostViewController ()

@property (nonatomic, strong) DZMenuTableListView *menuBar;  //条件选择器
@property (nonatomic, strong) NSArray *dataArray;  //!< <#属性注释#>

@end

@implementation DZGaoPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downloadPosMenuListData];
    [self configPostViewController];
}

-(void)configPostViewController{
    self.menuBar = [[DZMenuTableListView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, kToolBarHeight)];
    [self.view addSubview:self.menuBar];
    self.menuBar.backgroundColor = [UIColor whiteColor];
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

@end
