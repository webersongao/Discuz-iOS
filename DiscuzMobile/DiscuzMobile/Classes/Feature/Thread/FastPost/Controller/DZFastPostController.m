//
//  DZFastPostController.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/7/18.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZFastPostController.h"
#import "DZPostSelectController.h"
#import "UIImageView+FindHairline.h"

@interface DZFastPostController ()

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;
@property (nonatomic, strong) DZPostSelectController *listVC;
@property (nonatomic, strong) UINavigationController *naviVC;

@end

@implementation DZFastPostController

- (void)viewWillDisappear:(BOOL)animated {
    _navBarHairlineImageView.hidden = NO;
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    _navBarHairlineImageView.hidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self presentViewController:self.naviVC animated:NO completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _navBarHairlineImageView = [UIImageView findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self configNaviBar:@"" type:NaviItemText Direction:NaviDirectionLeft];
    
    self.listVC.tabbarHeight = self.tabbarHeight;
}

- (DZPostSelectController *)listVC {
    if (!_listVC) {
        _listVC = [[DZPostSelectController alloc] init];
    }
    return _listVC;
}

- (UINavigationController *)naviVC {
    if (!_naviVC) {
        _naviVC = [[UINavigationController alloc] initWithRootViewController:self.listVC];
    }
    return _naviVC;
}

@end
