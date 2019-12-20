//
//  DZAttachModel.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZAttachModel.h"

@implementation DZAttachModel

+ (NSDictionary*)modelCustomPropertyMapper {
    return @{
        @"attch_desc" : @"description",
    };
}

@end
