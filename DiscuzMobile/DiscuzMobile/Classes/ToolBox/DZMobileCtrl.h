//
//  DZMobileCtrl.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DZRootTabBarController.h"
#import "DZBaseNavigationController.h"
#import "DZForumIndexModel.h"

@interface DZMobileCtrl : NSObject

+(instancetype)sharedCtrl;

@property(nonatomic,strong,readonly) DZRootTabBarController *rootTababar;

@property(nonatomic,strong,readonly) DZBaseNavigationController *mainNavi;

@property (nonatomic, strong) DZForumIndexModel *forumInfo;  //!< 论坛全局数据

+ (BOOL)IsEnableWifi;

//网络是否联通，不仅仅wifi
+ (BOOL)connectedNetwork;

/// 设置tabbar 和 mainNavi
-(void)setTababar:(UITabBarController *)Tababar mainNavi:(UINavigationController *)mainNavi;

- (void)showServerAlertError:(NSError *)error;

@end


