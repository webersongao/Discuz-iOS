//
//  DZLoginResModel.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/7.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZLoginResModel.h"

@implementation DZRegInputModel

-(BOOL)isValidate{
    return (self.username.length && self.password.length && self.password2.length && self.email.length);
}

@end

@implementation DZLoginResModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Variables" : [DZGlobalModel class]};
}

@end
