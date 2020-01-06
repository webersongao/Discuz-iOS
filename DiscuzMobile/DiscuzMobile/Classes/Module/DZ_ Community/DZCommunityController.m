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
    BOOL m_isList;
    BOOL m_isForum;
}
@property(nonatomic,strong)DZForumController *forumVC;
@property (nonatomic, strong) UIButton *switchButton;  //!< 样式切换按钮
@property(nonatomic,strong)DZDiscoverController *discoverVC;


@end

@implementation DZCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.forumVC = [[DZForumController alloc] init];
    self.discoverVC = [[DZDiscoverController alloc] init];
    
    [self addChildViewController:self.forumVC];
    [self addChildViewController:self.discoverVC];
    [self.view addSubview:self.discoverVC.view];
    
    [self dz_bringNavigationBarToFront];
    [self.dz_NavigationBar addSubview:self.switchButton];
    [self configNaviBar:@"切换" type:NaviItemText Direction:NaviDirectionLeft];
    [self configNaviBar:@"bar_search" type:NaviItemImage Direction:NaviDirectionRight];
}

-(BOOL)DZ_hideTabBarWhenPushed{
    return NO;
}

-(void)switchButtonAction:(UIButton *)button{
    if (m_isForum) {
        m_isList = !m_isList;
        [self.forumVC listStyleChangeWithBarClick:m_isList];
        self.switchButton.imageView.transform = CGAffineTransformMakeRotation((m_isList ? M_PI : 0));
        [self.switchButton setTitle:(m_isList ? @"列表模式" : @"九宫格模式") forState:UIControlStateNormal];
    }
}

-(void)leftBarBtnClick{
    KWEAKSELF
    if (m_isForum) {
        [weakSelf transitionFromViewController:self.forumVC toViewController:self.discoverVC duration:0.35 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            [weakSelf.forumVC.view removeFromSuperview];
            [weakSelf.view addSubview:weakSelf.discoverVC.view];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.switchButton.alpha = 0;
            }];
        }];
    }else{
        [weakSelf transitionFromViewController:self.discoverVC toViewController:self.forumVC duration:0.35 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [weakSelf.discoverVC.view removeFromSuperview];
            [weakSelf.view addSubview:weakSelf.forumVC.view];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.switchButton.alpha = 1;
            }];
        }];
    }
    m_isForum = !m_isForum;
    [weakSelf dz_bringNavigationBarToFront];
}

-(void)rightBarBtnClick{
    [[DZMobileCtrl sharedCtrl] PushToSearchController];
}


-(UIButton *)switchButton{
    if (_switchButton == nil) {
        _switchButton = [UIButton ButtonNormalWithFrame:CGRectMake((KScreenWidth - 120)/2.f, KNavi_ContainStatusBar_Height - kToolBarHeight, 120, kToolBarHeight) title:@"九宫格模式" titleFont:KBoldFont(16.f) titleColor:[UIColor orangeColor] normalImgPath:@"manu_downarr" touchImgPath:@"manu_downarr" isBackImage:NO];
        [_switchButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsImageRight imageTitleSpace:5.f];
        [_switchButton addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _switchButton.backgroundColor = [UIColor whiteColor];
        _switchButton.layer.cornerRadius = 3.f;
        _switchButton.clipsToBounds = YES;
        _switchButton.alpha = 0;
    }
    return _switchButton;
}



@end
