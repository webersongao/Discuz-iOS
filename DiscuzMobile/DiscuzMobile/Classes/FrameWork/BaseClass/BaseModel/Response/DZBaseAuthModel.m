//
//  DZBaseAuthModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/6.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseAuthModel.h"

@implementation DZBaseAuthModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"threadtypes" : [DZThreadTypesModel class],
             @"allowperm" : [DZThreadPermModel class],
             @"forum" : [DZForumModel class],
             @"activity_setting" : [DZActivitySetModel class]
    };
}

@end
