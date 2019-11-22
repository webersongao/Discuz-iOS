//
//  DZForumIndexModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZForumIndexModel.h"

@implementation DZForumIndexModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"catlist" : [DZCateListModel class],
             @"forumlist" : [DZBaseForumModel class]
    };
}

@end
