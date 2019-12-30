//
//  DZForumTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/8.
//  Copyright © 2019年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZSecAuthModel.h"

typedef enum : NSUInteger {
    collectForum,
    collectThread,
} collectType;

@interface DZForumTool : NSObject

// 收藏板块
+ (void)DZ_CollectionForum:(NSString *)fId success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

// 收藏帖子
+ (void)DZ_CollectionThread:(NSString *)tid success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

// 取消收藏（帖子、板块）
+ (void)DZ_DeleCollection:(NSString *)fid type:(collectType)type success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

// 赞主题
+ (void)DZ_PraiseRequestTid:(NSString *)tid successBlock:(void(^)(void))success failureBlock:(void(^)(NSError *error))failure;

// 刷新验证码 验证问题
+ (void)DZ_DownAuthSeccode:(NSString *)type success:(void(^)(DZSecAuthModel *authModel))success failure:(void(^)(NSError *error))failure;


@end












