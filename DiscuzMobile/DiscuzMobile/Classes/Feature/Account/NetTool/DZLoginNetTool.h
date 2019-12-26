//
//  DZLoginNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZLoginResModel.h"

@interface DZLoginNetTool : NSObject

// 用户 密码登录 或 第三方登录
+ (void)DZ_UserLginWithNameOrThirdService:(NSDictionary *)dic getData:(NSDictionary *)getData completion:(void(^)(DZLoginResModel *resModel))completion;


/// 用户 注册
+ (void)DZ_UserRegisterWithName:(NSDictionary *)postData getData:(NSDictionary *)getData completion:(void(^)(DZLoginResModel *resModel,DZBackMsgModel *msgModel))completion;

/// 微信绑定
+ (void)DZ_WeixinLoginWithName:(NSString *)name passWord:(NSString *)pass  completion:(void(^)(DZLoginResModel *resModel))completion;




@end


