//
//  DZCommunityController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/29.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZCommunityController.h"
#import "DZForumController.h"
#import "DZDiscoverController.h"


@interface DZCommunityController ()
{
    BOOL m_isForum;
}
@property(nonatomic,strong)DZForumController *forumVC;
@property(nonatomic,strong)DZDiscoverController *discoverVC;


@end

@implementation DZCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.forumVC = [[DZForumController alloc] init];
    self.discoverVC = [[DZDiscoverController alloc] init];
    
    [self addChildViewController:self.forumVC];
    [self addChildViewController:self.discoverVC];
    
    [self dz_bringNavigationBarToFront];
    [self.view addSubview:self.discoverVC.view];
    [self configNaviBar:nil type:NaviItemText Direction:NaviDirectionLeft];
    [self configNaviBar:@"切换" type:NaviItemText Direction:NaviDirectionRight];
}

-(BOOL)DZ_hideTabBarWhenPushed{
    return NO;
}

-(void)rightBarBtnClick{
    
    KWEAKSELF
    if (m_isForum) {
        [weakSelf transitionFromViewController:self.forumVC toViewController:self.discoverVC duration:0.35 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [weakSelf.forumVC.view removeFromSuperview];
            [weakSelf.view addSubview:weakSelf.discoverVC.view];
        } completion:^(BOOL finished) {
        }];
    }else{
        [weakSelf transitionFromViewController:self.discoverVC toViewController:self.forumVC duration:0.35 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [weakSelf.discoverVC.view removeFromSuperview];
            [weakSelf.view addSubview:weakSelf.forumVC.view];
        } completion:^(BOOL finished) {
        }];
    }
    m_isForum = !m_isForum;
    [weakSelf dz_bringNavigationBarToFront];
}




@end
