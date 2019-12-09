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


// 是否绑定成功
-(BOOL)isBindSuccess{
    if ([self.Message.messageval containsString:Msg_BindSucc]) {
        return YES;
    }
    return NO;
}

// 是否绑定了第三方账号
-(BOOL)isBindThird{
    if ([self.Message.messageval containsString:Msg_No_bind]) {
        return NO;
    }
    return YES;
}



@end
