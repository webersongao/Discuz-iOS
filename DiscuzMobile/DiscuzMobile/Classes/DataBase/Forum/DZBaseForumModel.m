//
//  DZBaseForumModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseForumModel.h"

@implementation DZBaseForumModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"forum_desc" : @"description"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sublist" : [DZBaseForumModel class]
    };
}

- (NSString *)description {
    return [NSString stringWithFormat:@"fid:%@，版块名：%@",_fid,_name];
}


@end
