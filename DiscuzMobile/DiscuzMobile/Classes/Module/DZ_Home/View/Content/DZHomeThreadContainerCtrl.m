//
//  DZHomeThreadContainerCtrl.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/4.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZHomeThreadContainerCtrl.h"
#import "DZContainerController.h"
#import "DZHomeBestListCtrl.h"
#import "DZHomeNewListCtrl.h"
#import "FootmarkController.h"
#import "DZSettingController.h"

@interface DZHomeThreadContainerCtrl ()

@property (nonatomic, strong) NSMutableArray *controllerArr;
@property (nonatomic, strong) DZContainerController *rootVC;

@end

@implementation DZHomeThreadContainerCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNaviBar];
    [self configDiscoverPageView];
}

-(void)configNaviBar {
    [self configNaviBar:@"setting" type:NaviItemImage Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
}

- (void)configDiscoverPageView {
    
    [self addItemClass:[DZHomeNewListCtrl class] andTitle:@"最新"];
    [self addItemClass:[DZHomeBestListCtrl class] andTitle:@"精华"];
    
    CGRect segmentRect = CGRectMake(0, 0, KScreenWidth, kHomeSegmentHeight);
    self.rootVC = [[DZContainerController alloc] init];
    self.rootVC.sendNotify = YES;
    [self.rootVC setSubControllers:self.controllerArr parentController:self andSegmentRect:segmentRect];
}

-(void)setListOffSetY:(CGPoint)listOffSet{
    _listOffSet = listOffSet;
    self.rootVC.currentController.tableView.contentOffset = listOffSet;
}

-(void)setContentScrollEnabled:(BOOL)contentScrollEnabled{
    _contentScrollEnabled = contentScrollEnabled;
//    self.rootVC.currentController.tableView.scrollEnabled = contentScrollEnabled;
    for (UITableViewController *listVC in self.rootVC.viewControllers) {
        if ([listVC isEqual:self.rootVC.currentController]) {
            self.rootVC.currentController.tableView.scrollEnabled = contentScrollEnabled;
        }else{
           self.rootVC.currentController.tableView.scrollEnabled = !contentScrollEnabled;
        }
    }
}
-(void)listViewDidScroll:(UIScrollView *)scrollView{
    if (self.contentDelegate && [self.contentDelegate respondsToSelector:@selector(threadListContentView:scrollDidScroll:)]) {
        [self.contentDelegate threadListContentView:scrollView scrollDidScroll:scrollView.contentOffset.y];
    }
}


- (void)addItemClass:(Class)class andTitle:(NSString *)title {
    DZHomeThreadListBaseCtrl *vc = [class new];
    vc.title = title;
    KWEAKSELF
    vc.didScrollAction = ^(UIScrollView *scrollView) {
        [weakSelf listViewDidScroll:scrollView];
    };
    [self.controllerArr addObject:vc];
}

- (void)leftBarBtnClick {
    DZSettingController *setVC = [[DZSettingController alloc] init];
    [self showViewController:setVC sender:nil];
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl] PushToSearchController];
}

- (NSMutableArray *)controllerArr {
    if (_controllerArr == nil) {
        _controllerArr = [NSMutableArray array];
    }
    return _controllerArr;
}

@end
