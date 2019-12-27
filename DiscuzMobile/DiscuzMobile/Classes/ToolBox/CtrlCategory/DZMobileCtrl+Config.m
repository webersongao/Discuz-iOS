//
//  DZMobileCtrl+Config.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/7.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl+Config.h"

@implementation DZMobileCtrl (Config)

// 进行数据的初始化配置
-(void)cofigLocalDataInfo{
    self.Global = [DZLocalContext shared].GetLocalGlobalInfo;
}

@end
