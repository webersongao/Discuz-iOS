//
//  DZMsgNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/11.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZApiRequest.h"
#import "DZBaseResModel.h"

@interface DZMsgNetTool : NSObject

/// 发送私信
+(void)DZ_PostMsgToOtherUser:(NSString *)message UserNamme:(NSString *)userName completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;



// 发送私信 多参数
+(void)DZ_SendMsgToOtherUser:(NSString *)message UserNamme:(NSString *)userName touid:(NSString *)touid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;

// 删除消息
+ (void)DZ_DeletePMMessage:(NSString *)touid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;



/// 删除 单个人 消息
+ (void)DZ_DeleteOneMessage:(NSString *)touid Pid:(NSString *)Pid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;






@end






