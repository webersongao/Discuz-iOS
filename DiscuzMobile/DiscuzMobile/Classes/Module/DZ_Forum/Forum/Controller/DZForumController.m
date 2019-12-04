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
{
    BOOL m_isList;
}
@property (nonatomic, strong) NSMutableArray *controllerArr;
@property (nonatomic, strong) DZContainerController *containVc;
@property (nonatomic, strong) DZForumIndexListController *indexListVC;
@property (nonatomic, strong) DZForumCollectionController *collectVC;
@property (nonatomic, strong) DZBaseViewController *currentVC;
@property (nonatomic, assign) BOOL isList;

@end

@implementation DZForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviBar];
    [self configForumView];
}

-(BOOL)hideTabBarWhenPushed{
    return NO;
}

-(void)configNaviBar {
    NSString *leftTitle = m_isList ? @"forum_list" : @"forum_collect";
    [self configNaviBar:leftTitle type:NaviItemImage Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
}

-(void)configForumView{
    self.currentVC = self.collectVC;
    [self addChildViewController:self.collectVC];
    [self dz_AddSubView:self.collectVC.view belowNavigationBar:YES];
}

- (void)leftBarBtnClick {
    m_isList = !m_isList;
    if (m_isList) {
        [self presentFormOldController:self.collectVC toNewController:self.indexListVC];
    }else{
        [self presentFormOldController:self.indexListVC toNewController:self.collectVC];
    }
    NSString *leftTitle = m_isList ? @"forum_list" : @"forum_collect";
    [self configNaviBar:leftTitle type:NaviItemImage Direction:NaviDirectionLeft];
}


- (void)presentFormOldController:(DZBaseViewController *)oldController toNewController:(DZBaseViewController *)newController{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    } completion:^(BOOL finished) {
        if(finished){
            self.currentVC = newController;
            [oldController removeFromParentViewController];
            [self dz_AddSubView:newController.view belowNavigationBar:YES];
        }else{
            self.currentVC = oldController;
        }
    }];
}

- (void)rightBarBtnClick {
    [[DZMobileCtrl sharedCtrl] PushToSearchController];
}

- (DZForumIndexListController *)indexListVC {
    if (_indexListVC == nil) {
        _indexListVC = [[DZForumIndexListController alloc] init];
    }
    return _indexListVC;
}

- (DZForumCollectionController *)collectVC {
    if (_collectVC == nil) {
        _collectVC = [[DZForumCollectionController alloc] init];
    }
    return _collectVC;
}

@end
