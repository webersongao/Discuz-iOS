//
//  AppDelegate+Config.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "AppDelegate+Config.h"
#import "DZLoginModule.h"
#import "RNCachingURLProtocol.h"
#import "DZRootTabBarController.h"
#import "DZShareCenter.h"

@implementation AppDelegate (Config)


-(void)Config_WhenAppDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
        [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:60];
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
        // 注册监听键盘是否弹起
        [DZMonitorKeyboard shareInstance];

        // 判断网络
        [JTRequestOperation startMonitoring];
        
        if (![self isFirstInstall]) {
            // 设置 自动登录 cookie等
            [DZLoginModule setAutoLogin];
            [self checkAppDZVersionUpdate];
        }
        
        // 开启拉取全局配置参数
        [self loadForumGlobalInfofromServer];
        
        // 分享平台参数配置
        [[DZShareCenter shareInstance] setupShareConfigure];
        
        // 设置开机启动画面
        [self loadAppLaunchScreenView];
        
        [self initCacheConfigure];
        
        // 修改iOS12.1 tababar的图标漂浮上移的问题
        [[UITabBar appearance] setTranslucent:NO];
        
    //    [NSThread sleepForTimeInterval:1];
        [self launchSDKConfigWithOptions:launchOptions];
    
}


- (void)initCacheConfigure {
    // 离线缓存
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
//    [NSURLProtocol registerClass:[WebImageCacheUrlProtocol class]];
    
//    SDWebImageDownloaderConfig *coonfig = [[SDWebImageDownloaderConfig alloc] init];
//    coonfig.downloadTimeout = 10;
//    coonfig.maxConcurrentDownloads = 6;
//    coonfig.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
//   SDWebImageDownloader *downloader = [[SDWebImageDownloader alloc] initWithConfig:coonfig];
//    // 设置图片缓存信息
//
//    SDImageCacheConfig *cacheConfig = [[SDImageCacheConfig alloc] init];
//    cacheConfig.maxCacheAge = 7 * 24 * 60 * 60; //7天
//    cacheConfig.maxCacheSize = 1024 * 1024 * 100; //100MB
//    cacheConfig.maxMemoryCost = 1024 * 1024 * 40; //40MB
}

- (BOOL)isFirstInstall {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        return YES;
    }
    return NO;
}

@end
