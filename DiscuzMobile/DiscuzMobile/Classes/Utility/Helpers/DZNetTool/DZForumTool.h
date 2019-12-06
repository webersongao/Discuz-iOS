//
//  DZForumTool.h
//  DiscuzMobile
//
//  Created by HB on 2017/6/13.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

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


@end
