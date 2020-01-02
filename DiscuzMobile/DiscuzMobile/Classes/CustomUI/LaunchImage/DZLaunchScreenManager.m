//
//  DZLaunchScreenManager.m
//  DiscuzMobile
//
//  Created by HB on 17/3/28.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZLaunchScreenManager.h"
#import "UIView+TYLaunchAnimation.h"
#import "TYLaunchFadeScaleAnimation.h"
#import "UIImage+TYLaunchImage.h"
#import "DZLaunchImageView.h"

@implementation DZLaunchScreenManager

+ (instancetype)shareInstance {
    static DZLaunchScreenManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DZLaunchScreenManager alloc] init];
    });
    return manager;
}

- (void)setLaunchView {
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        // 开机启动画 广告页面
        self.launchImageView = [[DZLaunchImageView alloc] initWithImage:[UIImage ty_getLaunchImage]];
        [self.launchImageView addInWindow];
        // 不是第一次启动 设置开机启动动画
        [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
            //            request.urlString = url_LaunchImage;
            request.timeoutInterval = 2;
        } success:^(id responseObject, JTLoadType type) {
            DLog(@"responseObject:%@",responseObject);
            [self anylyLaunchData:responseObject];
        } failed:^(NSError *error) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:NO];
            //            DLog(@"请求超时或失败，加载缓存本地图片");
        }];
    }
}

- (void)anylyLaunchData:(id)resp {
    
    
    //    [self test];
    //    return;
    KWEAKSELF;
    [self.launchImageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeAnimationWithDelay:5.0] completion:^(BOOL finished) {
        DLog(@"finished");
    }];
    if ([DataCheck isValidString:[[[resp objectForKey:@"Variables"] objectForKey:@"openimage"] objectForKey:@"imgsrc"]]) {
        NSString *openimageStr = [[[resp objectForKey:@"Variables"] objectForKey:@"openimage"] objectForKey:@"imgsrc"];
        
        openimageStr = [openimageStr makeDomain];
        
        self.launchImageView.URLString = openimageStr;
        // 点击广告block
        [self.launchImageView setClickedImageURLHandle:^(NSString *URLString) {
            [weakSelf pushAdViewCntroller:[[[resp objectForKey:@"Variables"] objectForKey:@"openimage"] objectForKey:@"imgurl"]];
        }];
    } else {
        self.launchImageView.URLString = @"";
    }
}

- (void)test {
    KWEAKSELF;
    [self.launchImageView showInWindowWithAnimation:[TYLaunchFadeScaleAnimation fadeAnimationWithDelay:5.0] completion:^(BOOL finished) {
        DLog(@"finished");
    }];
    NSString *openimageStr = @"http://5b0988e595225.cdn.sohucs.com/images/20190614/050fa6c11ad14234a901f9f633f33126.jpeg";
    self.launchImageView.URLString = openimageStr;
    // 点击广告block
    [self.launchImageView setClickedImageURLHandle:^(NSString *URLString) {
        [weakSelf pushAdViewCntroller:@"https://www.baidu.com"];
    }];
}

// 点击启动页跳转的控制器，webview
- (void)pushAdViewCntroller:(NSString *)Url {
    
    [[DZMobileCtrl sharedCtrl] PushToWebViewController:Url];
    
}


@end
