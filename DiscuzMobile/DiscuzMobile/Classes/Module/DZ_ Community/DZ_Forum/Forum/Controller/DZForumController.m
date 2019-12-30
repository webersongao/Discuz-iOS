//
//  DZForumController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/8.
//  Copyright © 2019年 comsenz-service.com.  All rights reserved.
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

-(void)configNaviBar {
    NSString *leftTitle = m_isList ? @"forum_list" : @"forum_collect";
    [self configNaviBar:leftTitle type:NaviItemImage Direction:NaviDirectionRight];
    [self configNaviBar:@"社区" type:NaviItemText Direction:NaviDirectionLeft];
}

-(void)configForumView{
    self.currentVC = self.collectVC;
    [self addChildViewController:self.collectVC];
    [self.dz_NavigationBar removeFromSuperview];
    [self dz_AddSubView:self.collectVC.view belowNavigationBar:YES];
}

- (void)presentFormOldController:(DZBaseViewController *)oldController toNewController:(DZBaseViewController *)newController{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
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


- (void)leftBarBtnClick {
    
}



- (void)rightBarBtnClick {
    m_isList = !m_isList;
    if (m_isList) {
        [self presentFormOldController:self.collectVC toNewController:self.indexListVC];
    }else{
        [self presentFormOldController:self.indexListVC toNewController:self.collectVC];
    }
    NSString *leftTitle = m_isList ? @"forum_list" : @"forum_collect";
    [self configNaviBar:leftTitle type:NaviItemImage Direction:NaviDirectionLeft];
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
