//  2017branch
//  AppDelegate.m
//  DiscuzMobile
//
//  Created by HB on 16/7/12.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import "AppDelegate.h"
#import "DZLoginModule.h"
#import "RNCachingURLProtocol.h"
#import "DZRootTabBarController.h"
#import "DZShareCenter.h"
#import "AppDelegate+SDK.h"
#import "AppDelegate+Launch.h"
#import "AppDelegate+Data.h"
#import "AppDelegate+Update.h"
#import "WebImageCacheUrlProtocol.h"


#define _IPHONE80_ 80000

@implementation AppDelegate

static AppDelegate *m_appDelegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    m_appDelegate = self;
    
    DZRootTabBarController * rootVC = [[DZRootTabBarController alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
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
    
    return YES;
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

#pragma mark - Status bar 点击tableview滚到顶部
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint location = [[[event allTouches] anyObject] locationInView:self.window];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    if (CGRectContainsPoint(statusBarFrame, location)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DZ_STATUSBARTAP_Notify object:nil];
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    self.isOpenUrl = YES;
    return YES;
}

+ (AppDelegate *)appDelegate {
    return m_appDelegate;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
#pragma mark - 添加首次使用指导
    if ([self isFirstInstall]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"COOKIEVALU"];
        //        // 首次打开APP
        //        DZInstroductionView *helpView = [[DZInstroductionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //        [self.window addSubview:helpView];
        //
        //        NSMutableArray *imageArr = [NSMutableArray array];
        //        for (int i = 0; i < 6; i ++) {
        //            [imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"instroduction%d.jpg",i]]];
        //        }
        //        [helpView setPerpage:imageArr];
        //        helpView.dismissBlock = ^ {
        //            [[NSNotificationCenter defaultCenter] postNotificationName:DZ_FIRSTAPP_Notify object:nil];
        //        };
    } else {
        if (!self.isOpenUrl) {
            // 检查cookie是否过期
            [DZLoginModule checkCookie];
        }
        self.isOpenUrl = NO;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    DLog(@"内存警告了");
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (BOOL)isFirstInstall {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        return YES;
    }
    return NO;
}

@end
