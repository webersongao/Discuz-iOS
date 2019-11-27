//
//  DZBaseVarModel.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZBaseVarModel.h"

@implementation DZBaseVarModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"group" : [DZGroupModel class],
             @"notice" : [DZNoticeModel class]
    };
}


@end
