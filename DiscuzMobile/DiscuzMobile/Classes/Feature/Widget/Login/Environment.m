//
//  Environment.m
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/7.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "Environment.h"

@implementation Environment

+ (Environment *)sharedEnvironment
{
    static Environment * sharedEnvironment;
    @synchronized(self) {
        if (!sharedEnvironment) {
            sharedEnvironment = [[Environment alloc] init];
        }
        return sharedEnvironment;
    }
}

+ (NSDictionary*)modelCustomPropertyMapper {
    return @{
        @"authKey" : @"cookiepre",
    };
}

-(void)setAuthKey:(NSString *)authKey{
    _authKey = [authKey stringByAppendingString:@"auth"];
}

@end
