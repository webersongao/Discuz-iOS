//
//  DZMyThreadVarModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMyThreadVarModel.h"


@implementation DZThreeadItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"src_new" : @"new",
             @"src_id" : @"id"};
}

@end

@implementation DZMyThreadVarModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DZThreeadItemModel class]};
}

@end
