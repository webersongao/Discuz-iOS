//
//  DZiFlyTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/14.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZiFlyTool.h"

@interface DZiFlyTool ()

@end

@implementation DZiFlyTool

static DZiFlyTool *instance = nil;

+(instancetype)sharedTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


@end
