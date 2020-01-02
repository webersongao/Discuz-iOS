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

@property (nonatomic, strong) NSMutableArray *controllerArr;
@property (nonatomic, strong) DZContainerController *containVc;
@property (nonatomic, strong) DZForumIndexListController *indexListVC;
@property (nonatomic, strong) DZForumCollectionController *collectVC;
@property (nonatomic, assign) BOOL isList;

@end

@implementation DZForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configForumView];
    [self configNavigationBar];
}

-(void)configNavigationBar {
    [self configNaviBar:@"forum_collect" type:NaviItemImage Direction:NaviDirectionRight];
}

-(void)configForumView{
    [self addChildViewController:self.collectVC];
    [self addChildViewController:self.indexListVC];
    [self.dz_NavigationBar removeFromSuperview];
    [self.view addSubview:self.collectVC.view];
}

- (void)presentFormOldCtrl:(DZBaseViewController *)oldVC toNewCtrl:(DZBaseViewController *)newVC{
    
    [self transitionFromViewController:oldVC toViewController:newVC duration:0.35 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [oldVC.view removeFromSuperview];
    } completion:^(BOOL finished) {
        [self.view addSubview:newVC.view];
    }];
}

- (void)listStyleChangeWithBarClick:(BOOL)isList {
    if (isList) {
        [self presentFormOldCtrl:self.collectVC toNewCtrl:self.indexListVC];
    }else{
        [self presentFormOldCtrl:self.indexListVC toNewCtrl:self.collectVC];
    }
    NSString *leftTitle = isList ? @"forum_list" : @"forum_collect";
    [self configNaviBar:leftTitle type:NaviItemImage Direction:NaviDirectionRight];
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
