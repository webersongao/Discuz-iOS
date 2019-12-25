//
//  DZMobileCtrl+Tool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/25.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMobileCtrl+Tool.h"

@implementation DZMobileCtrl (Tool)


+(void)postNotification:(NSString *)name obj:(id)obj userinfo:(NSDictionary *)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:info];
}

+(void)addObserver:(id)observer sel:(SEL)selName name:(NSString *)name{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selName name:name object:nil];
}


@end
