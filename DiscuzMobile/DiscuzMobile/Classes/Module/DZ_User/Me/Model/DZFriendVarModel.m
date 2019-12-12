//
//  DZFriendVarModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZFriendVarModel.h"

@implementation DZFriendModel

@end

@implementation DZFriendVarModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [DZFriendModel class]};
}

@end

