//
//  DZDiscoverCateController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZDiscoverCateController.h"
#import "DZDiscoverListView.h"
#import "DZBaseForumModel.h"
#import "DZThreadNetTool.h"

@interface DZDiscoverCateController ()

@property (nonatomic, strong) DZDiscoverListView *listView;  //!< 属性注释
@property (nonatomic, strong) DZBaseForumModel *forumModel;  //!< 属性注释
@property (nonatomic, strong) DZThreadVarModel *VarModel;  //!< 属性注释
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;  //!< 属性注释
@property (nonatomic, strong) NSMutableArray *allArray;  //!< 属性注释
@property (nonatomic, assign) NSInteger notThisFidCount;

@end

@implementation DZDiscoverCateController

- (instancetype)initWithFrame:(CGRect)frame Model:(DZBaseForumModel *)model
{
    self = [super init];
    if (self) {
        self.allArray = [NSMutableArray array];
        self.dataSourceArr = [NSMutableArray array];
        self.listView = [[DZDiscoverListView alloc] initWithListFrame:frame];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dz_HideNaviBar = YES;
    [self.view addSubview:self.listView];
}

-(void)updateDiscoverCateControllerView{
    [self downLoadListData:self.page andLoadType:JTRequestTypeCache];
}

#pragma mark - 数据下载
- (void)downLoadListData:(NSInteger)page andLoadType:(JTLoadType)loadType {
    
    [self.HUD showLoadingMessag:@"加载中" toView:self.view];
    [DZThreadNetTool DZ_DownloadForumListWithType:loadType fid:self.forumModel.fid page:page listType:DZ_ListNew completion:^(DZThreadResModel *threadResModel, BOOL isCache, NSError *error) {
        [self.HUD hide];
        if (threadResModel) {
            [self.listView.mj_header endRefreshing];
            //            if (threadResModel.Message && !threadResModel.Message.isAuthorized) {
            //                [UIAlertController alertTitle:nil message:threadResModel.Message.messagestr controller:self doneText:@"知道了" cancelText:nil doneHandle:^{
            //                    [self.navigationController popViewControllerAnimated:YES];
            //                } cancelHandle:nil];
            //                [self.HUD hideAnimated:YES];
            //                return ;
            //            }
            //
            self.VarModel = threadResModel.Variables;
            
            //            if (page == 1 && (isCache == NO || loadType == JTRequestTypeRefresh)) {
            //                [self showVerifyRemind:self.VarModel.forum.threadmodcount];
            //            }
            
            if (self.page == 1) { // 刷新列表
                // 刷新的时候移除数据源
                [self.dataSourceArr removeAllObjects];
                [self anylyeThreadListData:threadResModel];
            } else {
                [self.listView.mj_footer endRefreshing];
                [self anylyeThreadListData:threadResModel];
            }
            NSInteger threadsCount = threadResModel.Variables.forum.threadcount + self.notThisFidCount;
            if (threadsCount <= self.allArray.count) {
                [self.listView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.listView reloadData];
        }else{
            [self showServerError:error];
            [self.listView.mj_header endRefreshing];
            [self.listView.mj_footer endRefreshing];
        }
    }];
}

- (void)anylyeThreadListData:(DZThreadResModel *)responseObject {
    
    [self.VarModel updateVarModel:self.forumModel.fid andPage:self.page handle:^(NSArray *topArr, NSArray *commonArr, NSArray *allArr, NSInteger notFourmCount) {
        if (self.page == 1) {
            self.notThisFidCount = notFourmCount;
            [self.dataSourceArr addObject:[NSArray arrayWithArray:topArr]];
            [self.dataSourceArr addObject:[NSArray arrayWithArray:commonArr]];
            self.allArray = [NSMutableArray arrayWithArray:allArr];
        } else {
            if (commonArr.count) {
                DZThreadListModel *model1 = commonArr.firstObject;
                NSMutableArray *commonListArr = [NSMutableArray arrayWithArray:self.dataSourceArr.lastObject];
                DZThreadListModel *model2 = commonListArr.lastObject;
                if ([model1.tid isEqualToString:model2.tid]) {
                    [self.listView.mj_footer endRefreshingWithNoMoreData];
                    return;
                }
                [commonListArr addObjectsFromArray:commonArr];
                [self.dataSourceArr replaceObjectAtIndex:1 withObject:commonListArr];
            }
            if (allArr.count) {
                [self.allArray addObjectsFromArray:allArr];
            }
        }
    }];
}

#pragma mark   /********************* 初始化 *************************/







@end
