//
//  DZBaseResModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseResModel.h"
#import "DZBaseVarModel.h"

@implementation DZBaseResModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Message" : [DZBackMsgModel class]
    };
}





@end
