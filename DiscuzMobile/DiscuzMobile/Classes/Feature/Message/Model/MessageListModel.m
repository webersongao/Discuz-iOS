//
//  MessageListModel.m
//  DiscuzMobile
//
//  Created by HB on 2017/5/9.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "MessageListModel.h"

@implementation MessageEvarModel

@end

@implementation MessageListModel

+ (NSDictionary*)modelCustomPropertyMapper {
    return @{@"msg_id" : @"id",
             @"msg_new" : @"new"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"notevar" : [MessageEvarModel class]
    };
}

-(void)setNote:(NSString *)note{
    _note = [[checkNull(note) flattenHTMLTrimWhiteSpace:NO] transformationStr];
}

-(void)setMessage:(NSString *)message{
    _message = [message transformationStr];
}

@end
