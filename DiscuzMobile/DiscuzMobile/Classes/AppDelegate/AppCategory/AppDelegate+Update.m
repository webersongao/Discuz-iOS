//
//  AppDelegate+Update.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/21.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "AppDelegate+Update.h"
#import "DZVersionUpdate.h"
#import "DZUpdateAlertView.h"

@implementation AppDelegate (Update)

- (void)checkAppDZVersionUpdate {
    [DZVersionUpdate compareUpdate:^(NSString * _Nonnull newVersion, NSString * _Nonnull releaseNotes) {
        [DZUpdateAlertView showUpdateAlertWithVersion:newVersion Descriptions:@[releaseNotes]];
    }];
}


@end
