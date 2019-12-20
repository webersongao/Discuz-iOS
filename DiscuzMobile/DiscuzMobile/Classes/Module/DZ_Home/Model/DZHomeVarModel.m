//
//  DZHomeVarModel.m
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZHomeVarModel.h"

@implementation DZHomeVarModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DZThreadListModel class]};
}


@end



