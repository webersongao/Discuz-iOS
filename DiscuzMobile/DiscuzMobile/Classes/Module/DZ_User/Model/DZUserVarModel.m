//
//  DZUserVarModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/2.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZUserVarModel.h"


@implementation DZUserResModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Variables" : [DZUserVarModel class]};
}

@end

@implementation DZUserVarModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"space" : [DZSpaceModel class]};
}


@end



//@implementation DZExtItemModel
//
//@end
