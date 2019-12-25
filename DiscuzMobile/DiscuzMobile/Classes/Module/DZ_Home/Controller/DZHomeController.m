//
//  DZHomeController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZHomeController.h"
#import "DZHomeNetTool.h"
#import "DZHomeScrollView.h"


@interface DZHomeController ()

@property (nonatomic, strong) DZHomeScrollView *homeView;  //!< 属性注释

@end

@implementation DZHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configHomeControllerView];
    [self loadHomeForumDataFromServer];
    [self configHomeScroolViewAction];
}
-(BOOL)DZ_hideTabBarWhenPushed{
    return NO;
}
-(void)configHomeControllerView{
    
    [self.view addSubview:self.homeView];
    [self configNaviBar:@"bar_message" type:NaviItemImage Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
    
}

-(void)configHomeScroolViewAction{
    
}

-(void)loadHomeForumDataFromServer{
    KWEAKSELF
    [DZHomeNetTool DZ_HomeDownLoadHotforumData:^(NSArray <DZForumModel *>*array, NSError *error) {
        if (error) {
            [weakSelf showServerError:error];
        }else{
            [weakSelf setHeadHotForumData:array];
        }
    }];
}


-(void)setHeadHotForumData:(NSArray <DZForumModel *>*)listArray{
    [self.homeView.HeaderView reloadDataSource:listArray];
}

 /********************* 响应事件 *************************/
- (void)leftBarBtnClick {
    if (![self isLogin]) {
        return;
    }
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl] PushToSearchController];
}

 /********************* 初始化 *************************/

-(DZHomeScrollView *)homeView{
    if (_homeView == nil) {
        _homeView = [[DZHomeScrollView alloc] initWithFrame:CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KScreenHeight    - KNavi_ContainStatusBar_Height)];
        _homeView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight - KNavi_ContainStatusBar_Height + kHomeHeaderHeight);
    }
    return _homeView;
}


@end
