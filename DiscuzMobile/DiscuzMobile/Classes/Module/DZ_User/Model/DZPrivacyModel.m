//
//  DZPrivacyModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/2.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZPrivacyModel.h"

@implementation DZUserFeedModel

@end

@implementation DZUserViewModel

+ (NSDictionary*)modelCustomPropertyMapper {
    return @{
        @"friendNum" : @"friend",
    };
}

@end


@implementation DZProfileModel


@end



@implementation DZPrivacyModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"feed" : [DZUserFeedModel class],
             @"view" : [DZUserViewModel class],
             @"profile" : [DZProfileModel class]
    };
}

@end


