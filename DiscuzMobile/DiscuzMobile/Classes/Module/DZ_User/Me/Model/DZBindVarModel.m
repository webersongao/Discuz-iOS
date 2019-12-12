//
//  DZBindVarModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBindVarModel.h"

@implementation DZBindUser

-(void)setType:(NSString *)type{
    _type = type;
    if (type && [type isEqualToString:@"qq"]) {
        _icon = @"bound_qq";
        _name = @"QQ";
    } else {
        _icon = @"bound_wx";
        if ([type isEqualToString:@"minapp"]) {
            _name = @"小程序";
        } else {
            _name = @"微信";
        }
    }
}

@end



@implementation DZBindVarModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"users" : [DZBindUser class]};
}

@end
