//
//  AppDelegate+iflyMSC.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/14.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "AppDelegate+iflyMSC.h"
#import <iflyMSC/iflyMSC.h>


@implementation AppDelegate (iflyMSC)

-(void)launchXFSpeech{
    //Set APPID
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",DZ_iflyAppID];
    //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
    [IFlySpeechUtility createUtility:initString];
}



@end
