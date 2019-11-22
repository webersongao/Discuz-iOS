//
//  AppDelegate+Local.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/2/1.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//  启动 定位

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate (Local)<CLLocationManagerDelegate>

- (void)useLocal;
@end
