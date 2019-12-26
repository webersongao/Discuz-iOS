//
//  DZMobileCtrl.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl.h"
#import "PRLayouter.h"
#import "JTRequestOperation.h"
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
        [self MobileCtrlConfigration];
    }
    return self;
}

-(void)MobileCtrlConfigration{
 
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
    
}


+ (BOOL)IsEnableWifi{
    return ([JTRequestOperation shareInstance].netWork == networkWIFI);
}

//网络是否联通，不仅仅wifi
+ (BOOL)connectedNetwork{
    return ([JTRequestOperation shareInstance].netWork != networkError);
}


@end
