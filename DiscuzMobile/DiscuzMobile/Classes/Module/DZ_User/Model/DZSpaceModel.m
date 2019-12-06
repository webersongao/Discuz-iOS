//
//  DZSpaceModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/2.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZSpaceModel.h"

@implementation DZSpaceModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"group" : [DZUserGroupModel class],
             @"privacy" : [DZPrivacyModel class],
             @"admingroup" : [DZAdmingroupModel class]
    };
}

@end
