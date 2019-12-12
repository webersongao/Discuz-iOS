//
//  DZPostProperty.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZPostProperty.h"

@implementation DZPostThreadModel


@end

@implementation DZPostListItem

@end

@implementation DZPostForum

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"threadtypes" : [DZThreadTypesModel class]
    };
}

@end

@implementation DZPostPoll

@end


@implementation DZPostActivity

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"classType" : @"class",
    };
}

@end


