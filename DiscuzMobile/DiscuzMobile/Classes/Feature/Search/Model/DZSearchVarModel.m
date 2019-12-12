//
//  DZSearchVarModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZSearchVarModel.h"

@implementation DZSearchVarModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"notice" : [DZNoticeModel class],
             @"threadlist" : [DZSearchModel class]
    };
}



@end
