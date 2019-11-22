//
//  DZForumOldListController.m
//  PandaReader
//
//  Created by WebersonGao on 2018/10/25.
//

#import "DZForumOldListController.h"
#import "DZForumNetTool.h"
#import "PRNetWorkErrorView.h"

@interface DZForumOldListController ()<PRNetWorkErrorViewDelegate,DZForumListTableDelegate>

{
    NSInteger localPageid;
}
@property (nonatomic,strong) DZForumListTableView *listView;
@property (nonatomic,strong) PRNetWorkErrorView *listErrorView;
@property (nonatomic,strong) NSMutableArray *bookArray;
@end

@implementation DZForumOldListController

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        localPageid = 0;
        self.bookArray = [[NSMutableArray alloc] initWithCapacity:3];
        self.listView = [[DZForumListTableView alloc] initWithFrame:frame];
        self.listView.listDelegate = self;
        self.view = self.listView;
    }
    return self;
}

-(void)loadChildsViewFirstDataFromServer{
    
    if (!self.bookArray.count) {
        [self loadListViewFomrServerData:0];
    }
}

-(void)loadListViewFomrServerData:(NSInteger)pageid{
    
    if (![DZMobileCtrl connectedNetwork]){
        [self addErrorView:PRErrorViewNoNet];
        return;
    }else if (!self.subtype.length || !self.column.length){
        [self addErrorView:PRErrorViewNoData];
        return;
    }
    KWEAKSELF
//    [PRAppModule showLoading:self.listView];
//    [DZForumNetTool getVIPCategoryBooKInfoWithColumn:self.column subtype:self.subtype pageid:[NSString stringWithFormat:@"%ld",(pageid + 1)] success:^(DZVIPCategoryInfoModel * _Nonnull dataModel, NSArray * _Nonnull bookArray) {
//        if (pageid) {
//            localPageid = pageid;
//            [weakSelf.bookArray addObjectsFromArray:bookArray];
//        }else{
//            weakSelf.bookArray = [NSMutableArray arrayWithArray:bookArray];
//        }
//        if (weakSelf.bookArray.count) {
//            [weakSelf removeErrorview];
//            weakSelf.listView.dataModelArray = weakSelf.bookArray;
//            weakSelf.listView.is_next = dataModel.is_next;
//        }else{
//            [weakSelf addErrorView:PRErrorViewNoData];
//        }
////        [PRAppModule hideLoading];
//        if (dataModel.is_next) {
//            [weakSelf.listView.mj_footer endRefreshing];
//        }else{
//            [weakSelf.listView.mj_footer endRefreshingWithNoMoreData];
//        }
//    } failure:^(id data, NSError *error) {
//        if (!pageid) {
//                    [weakSelf addErrorView:PRErrorViewNoData];
//                }
//        //        [PRAppModule hideLoading];
//                [weakSelf.listView.mj_footer endRefreshing];
//    }];
}

#pragma -mark DZForumListTableDelegate
-(void)loadVIPCategoryTableViewMoreData:(DZForumListTableView *)VIPCategoryTableView{
    
    if (self.listView.is_next) {
        [self loadListViewFomrServerData:localPageid +1];
    }
}

#pragma -mark PRNetWorkErrorViewDelegate
- (void)tryAgainButtonDidClicked {
    [self loadListViewFomrServerData:0];
}

- (void)addErrorView:(PRErrorViewType)errorType {
    self.listView.scrollEnabled = NO;
    [self.listView addSubview:self.listErrorView];
    [self.listErrorView addErrorViewWithViewType:errorType];
}

- (void)removeErrorview {
    if (self.listErrorView && self.listErrorView.superview) {
        [self.listErrorView removeFromSuperview];
    }
    self.listView.scrollEnabled = YES;
}

-(PRNetWorkErrorView *)listErrorView{
    if (!_listErrorView) {
        _listErrorView = [[PRNetWorkErrorView alloc] initWithFrame:self.listView.bounds viewType:PRErrorViewNoNet];
        _listErrorView.delegate = self;
    }
    return _listErrorView;
}

-(void)dealloc{
//    LogMsg(@" ------ DZForumOldListController dealloc ");
}


@end
