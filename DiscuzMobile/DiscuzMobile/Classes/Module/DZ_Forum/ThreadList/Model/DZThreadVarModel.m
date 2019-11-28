//
//  DZThreadVarModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/28.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadVarModel.h"

@implementation DZThreadVarModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"threadtypes" : [DZThreadTypesModel class],
             @"allowperm" : [DZThreadPermModel class],
             @"forum" : [DZForumModel class],
             @"activity_setting" : [DZActivitySetModel class],
             @"forum_threadlist" : [DZThreadListModel class]
    };
}


@end
