//
//  DZPostVarModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZPostVarModel.h"

@implementation DZPostVarModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"allowperm" : [DZThreadPermModel class],
             @"threadtypes" : [DZThreadTypesModel class],
             @"activity_setting" : [DZActivitySetModel class],
             @"group" : [DZGroupModel class],
             @"notice" : [DZNoticeModel class],
             @"forum" : [DZPostForum class],
             @"thread" : [DZPostThreadModel class],
             @"special_poll" : [DZPostPoll class],
             @"special_activity" : [DZPostActivity class]
    };
}


@end

@implementation DZPosResModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Variables" : [DZPostVarModel class]
    };
}

@end



