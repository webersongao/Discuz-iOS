//
//  DZMobileCtrl.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl.h"
#import "PRLayouter.h"

@implementation DZMobileCtrl

static DZMobileCtrl *instance = nil;

+(instancetype)sharedCtrl{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化布局管理器
        [PRLayouter sharedLayouter];
    }
    return self;
}

-(void)setTababar:(UITabBarController *)Tababar mainNavi:(UINavigationController *)mainNavi{
    if ([Tababar isKindOfClass:[DZRootTabBarController class]]) {
        _rootTababar = (DZRootTabBarController *)Tababar;
    }
    
    if ([mainNavi isKindOfClass:[DZBaseNavigationController class]]) {
        _mainNavi = (DZBaseNavigationController *)mainNavi;
    }
}

- (void)showServerAlertError:(NSError *)error {
    if (error != nil) {
        NSString *message = [NSString stringWithFormat:@"错误:%@",[error localizedDescription]];
#ifdef DEBUG
        DLog(@"WBS 出现错误 %s 提示：%@",__FUNCTION__,message);
#else
        if (error.code == NSURLErrorTimedOut) {
            message = @"网络请求超时！";
        } else {
            message = @"服务器数据获取失败";
        }
#endif
        [MBProgressHUD showInfo:message];
    }
}

@end
