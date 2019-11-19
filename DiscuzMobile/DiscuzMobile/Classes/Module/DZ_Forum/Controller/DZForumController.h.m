//
//  DZHomeController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZForumController.h"
#import "DZHomeScrollView.h"

@interface DZForumController ()


@property (nonatomic, strong) DZHomeScrollView *homeScroll;  //!< <#属性注释#>

@end

@implementation DZForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.homeScroll];
    
}



-(DZHomeScrollView *)homeScroll{
    if (_homeScroll == nil) {
        _homeScroll = [[DZHomeScrollView alloc] initWithFrame:KView_OutNavi_Bounds];
        _homeScroll.bounces = NO;
    }
    return _homeScroll;
}

@end
