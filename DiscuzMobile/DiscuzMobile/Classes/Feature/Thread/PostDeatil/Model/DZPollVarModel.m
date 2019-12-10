//
//  DZPollVarModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZPollVarModel.h"

@implementation DZPollviewvote

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"voterlist" : [DZBaseUser class]
    };
}


@end


@implementation DZPollVarModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"viewvote" : [DZPollviewvote class]
    };
}

@end


@implementation DZVoteResModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Variables" : [DZPollVarModel class]
    };
}

@end


