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

-(BOOL)isAuthorized{
    if ([self.Message.messageval containsString:Msg_NoMedal] || [self.Message.messageval containsString:Msg_NoPermission] || [self.Message.messageval containsString:Msg_NoExistence]) {
        return NO;
    }
    return YES;
}



@end
