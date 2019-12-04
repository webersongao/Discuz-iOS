//
//  DZForumController.m
//  DiscuzMobile
//
//  Created by HB on 2017/5/4.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumController.h"
#import "DZForumCollectionController.h"
#import "DZForumIndexListController.h"
#import "DZContainerController.h"

static NSString *isFourmList = @"isFourmList";

@interface DZForumController()

@property (nonatomic, strong) NSMutableArray *controllerArr;
@property (nonatomic, strong) DZContainerController *containVc;
@property (nonatomic, strong) DZForumIndexListController *indexVC;
@property (nonatomic, strong) DZForumCollectionController *allVC;
@property (nonatomic, assign) BOOL isList;

@end

@implementation DZForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isList = [[NSUserDefaults standardUserDefaults] boolForKey:isFourmList];
    [self configNaviBar];
    [self configPageView];
    
    self.dz_NavigationItem.leftBarButtonItems.lastObject.customView.hidden = YES;
}
-(BOOL)hideTabBarWhenPushed{
    return NO;
}
-(void)configNaviBar {
    NSString *leftTitle = _isList ? @"forum_list" : @"forum_ranctangle";
    [self configNaviBar:leftTitle type:NaviItemImage Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
}

- (void)configPageView {
    if (_isList) {
        [self pageOfController:self.indexVC andTitle:nil];
    }else {
        [self pageOfController:self.allVC andTitle:nil];
    }
    _containVc = [[DZContainerController alloc] init];
    [self updateNaviSegmentBar];
}

- (void)updateNaviSegmentBar {
//        CGRect segmentRect = CGRectMake(0, 0, KScreenWidth, kToolBarHeight);
    CGRect segmentRect = CGRectMake(0, 0, KScreenWidth, 0);
    self.view.frame = CGRectMake(0, KNavi_ContainStatusBar_Height, KScreenWidth, KScreenHeight - KNavi_ContainStatusBar_Height);
    [_containVc setSubControllers:self.controllerArr parentController:self andSegmentRect:segmentRect];
}

- (void)pageOfController:(UIViewController *)controller andTitle:(NSString *)title {
    controller.title = title;
    [self.controllerArr addObject:controller];
}

- (void)leftBarBtnClick {
    
    while (self.controllerArr.count >= 1) {
        [self.controllerArr removeLastObject];
    }
    _isList = !_isList;
    if (_isList) {
        [self pageOfController:self.indexVC andTitle:@"全部"];
    } else {
        [self pageOfController:self.allVC andTitle:@"全部"];
    }
    
    [self updateNaviSegmentBar];
    [self configNaviBar];
    
    [[NSUserDefaults standardUserDefaults] setBool:_isList forKey:isFourmList];
    [_containVc.collectonView reloadData];
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl] PushToSearchController];
}

#pragma mark - getter
- (NSMutableArray *)controllerArr {
    if (!_controllerArr) {
        _controllerArr = [NSMutableArray array];
    }
    return _controllerArr;
}

- (DZForumIndexListController *)indexVC {
    if (_indexVC == nil) {
        _indexVC = [[DZForumIndexListController alloc] init];
    }
    return _indexVC;
}

- (DZForumCollectionController *)allVC {
    if (_allVC == nil) {
        _allVC = [[DZForumCollectionController alloc] init];
    }
    return _allVC;
}

@end
