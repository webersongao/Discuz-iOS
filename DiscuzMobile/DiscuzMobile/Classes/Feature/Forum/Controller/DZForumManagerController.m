//
//  DZForumManagerController.m
//  DiscuzMobile
//
//  Created by HB on 2017/5/4.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumManagerController.h"

#import "DZForumCollectionController.h"
#import "DZForumIndexListController.h"
#import "DZContainerController.h"

static NSString *isFourmList = @"isFourmList";

@interface DZForumManagerController()

@property (nonatomic, strong) NSMutableArray *controllerArr;
@property (nonatomic, strong) DZContainerController *containVc;
@property (nonatomic, strong) DZForumIndexListController *indexVC;
@property (nonatomic, strong) DZForumCollectionController *allVC;
@property (nonatomic, assign) BOOL isList;

@end

@implementation DZForumManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isList = [[NSUserDefaults standardUserDefaults] boolForKey:isFourmList];
    [self setNavc];
    [self setPageView];
    
    self.navigationItem.leftBarButtonItems.lastObject.customView.hidden = YES;
    
}

-(void)setNavc {
//    [self configNaviBar:@"" type:NaviItemText Direction:NaviDirectionLeft];
    NSString *leftTitle = _isList ? @"forum_list" : @"forum_ranctangle";
    [self configNaviBar:leftTitle type:NaviItemImage Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
}

- (void)setPageView {
    
//    DZForumCollectionController *hot = [[DZForumCollectionController alloc] initWithType:Forum_hot];
//    [self pageOfController:hot andTitle:@"热门"];
    if (_isList) {
        [self pageOfController:self.indexVC andTitle:@"全部"];
    }else {
        [self pageOfController:self.allVC andTitle:@"全部"];
    }
    _containVc = [[DZContainerController alloc] init];
    [self setNaviTab];
}

- (void)setNaviTab {
        CGRect segmentRect = CGRectMake(0, 0, KScreenWidth, 44);
//    CGRect segmentRect = CGRectMake(0, 0, KScreenWidth, 0);
    [_containVc setSubControllers:self.controllerArr parentController:self andSegmentRect:segmentRect];
    [_containVc.segmentedControl addObserver:self forKeyPath:@"selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:nil];
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
    
    [self setNaviTab];
    [self setNavc];
    
    [[NSUserDefaults standardUserDefaults] setBool:_isList forKey:isFourmList];
    [_containVc.collectonView reloadData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selectedSegmentIndex"]) {
//        id new = change[NSKeyValueChangeNewKey];
//        if ([new integerValue] == 0) {
//            [self configNaviBar:@"" type:NaviItemText Direction:NaviDirectionLeft];
//        } else if ([new integerValue] == 1) {
//            NSString *leftTitle = _isList ? @"forum_list" : @"forum_ranctangle";
//            [self configNaviBar:leftTitle type:NaviItemImage Direction:NaviDirectionLeft];
//        }
    }
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl]PushToSearchController];
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
        _allVC = [[DZForumCollectionController alloc] initWithType:Forum_index];
    }
    return _allVC;
}

@end
