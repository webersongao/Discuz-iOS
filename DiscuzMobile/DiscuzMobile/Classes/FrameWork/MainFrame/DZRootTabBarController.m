//
//  DZRootTabBarController.m
//  DiscuzMobile
//
//  Created by HB on 16/7/12.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import "DZRootTabBarController.h"
#import "DZBaseNavigationController.h"

#import "DZUserController.h"
#import "DZHomeController.h"
#import "DZFastPostController.h"
#import "DZCommunityController.h"
#import "DZHomeTestViewController.h"

@interface DZRootTabBarController () <UITabBarControllerDelegate>
@property (nonatomic, assign) NSInteger oldSelected;
@property (nonatomic, assign) NSInteger notitySelected;
@property (nonatomic, strong) UIButton *composeButton;
@end

@implementation DZRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [[DZMobileCtrl sharedCtrl] cofigLocalDataInfo];
    
    [self addChildViewControllers];
    
    //    [self.tabBar addSubview:self.composeButton];
    //    CGFloat b_width = self.tabBar.width / self.childViewControllers.count;
    //    CGFloat b_height = self.tabBar.height;
    //    self.composeButton.frame = CGRectMake(b_width, 0, b_width, b_height);
    //    [self.composeButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(@4);
    //        make.height.equalTo(@(b_height));
    //        make.width.equalTo(@(b_width));
    //    }];
    
    self.tabBar.tintColor = K_Color_Theme;
    self.tabBar.translucent = YES;
    //    [[UINavigationBar appearance] setBarTintColor:K_Color_NaviBar];
    self.selectedIndex = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ttsetSelectInex:) name:DZ_ConfigSelectedIndex_Notify object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self tabBarController:self didSelectViewController:self.selectedViewController];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[DZMobileCtrl sharedCtrl] setTababar:self mainNavi:self.selectedViewController];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        [[DZMobileCtrl sharedCtrl] setTababar:self mainNavi:self.selectedViewController];
    }
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (self.oldSelected == viewController.tabBarItem.tag) { // 双击刷新
        if (viewController.tabBarItem.tag == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:DZ_TabbarRefresh_Notify object:nil];
        }
    }
    self.oldSelected = viewController.tabBarItem.tag;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *baseNaviVC = (UINavigationController *)viewController;
        UIViewController *baseVC = baseNaviVC.topViewController;
        if ([baseVC isKindOfClass:[DZFastPostController class]]) {
            if (![DZLoginModule isLogged]) {
                [[DZMobileCtrl sharedCtrl] PresentLoginController];
                return NO;
            }
        }else {
            self.notitySelected = viewController.tabBarItem.tag;
        }
    }
    return YES;
}

- (void)ttsetSelectInex:(NSNotification *)notify {
    
    //    if (notify.userInfo != nil) {
    //        NSDictionary *userInfo = notify.userInfo;
    //        if ([[userInfo objectForKey:@"type"] isEqualToString:@"cancel"]) {
    //            if (self.selectedIndex == self.viewControllers.count - 1) {
    //                self.selectedIndex = 0;
    //            }
    //        } else if ([[userInfo objectForKey:@"type"] isEqualToString:@"loginSuccess"]) {
    //            self.selectedIndex = self.viewControllers.count - 1;
    //        }
    //    } else {
    //        self.selectedIndex = self.notitySelected;
    //    }
    //    self.oldSelected = self.selectedIndex;
}

- (void)addChildViewControllers {
    
    DZHomeController *homeVC = [[DZHomeController alloc] init];
    DZUserController *UserVC = [[DZUserController alloc] init];
    DZCommunityController *CommunityVC = [[DZCommunityController alloc] init];
    DZHomeTestViewController *testVC = [[DZHomeTestViewController alloc] initWithNibName:@"DZHomeTest" bundle:nil];
    
    [self addChildVc:testVC title:@"首页" image:@"homem" selectedImage:@"homes"];
    
    [self addChildVc:homeVC title:@"homs" image:@"homem" selectedImage:@"homes"];
    [self addChildVc:CommunityVC title:@"for" image:@"forumm" selectedImage:@"fourms"];
    [self addChildVc:UserVC title:@"mys" image:@"my" selectedImage:@"mys"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置子控制器的文字 设置tabbar和navigationBar的文字
    childVc.title = title;
    
    // 设置子控制器的图片
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = K_Color_DarkText;
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = K_Color_Theme;
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    DZBaseNavigationController *nav = [[DZBaseNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.tag = self.viewControllers.count;
    // 添加为子控制器
    [self addChildViewController:nav];
}

- (BOOL)shouldAutorotate {
    return NO;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIButton *)composeButton {
    if (!_composeButton) {
        _composeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _composeButton.alpha = 1;
        [_composeButton setImage:[UIImage imageNamed:@"addTz"] forState:UIControlStateNormal];
    }
    return _composeButton;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
