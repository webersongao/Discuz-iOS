//
//  DZCollectionTool.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/13.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZCollectionTool.h"

@implementation DZCollectionTool


// 收藏板块
+ (void)DZ_CollectionForum:(NSString *)fid success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    NSString *forumId = checkNull(fid);
    NSString *formhash = checkNull([Environment sharedEnvironment].formhash);
    if (!forumId.length) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_CollectionForum;
        request.methodType = JTMethodTypePOST;
        request.getParam = @{@"id":checkNull(forumId)};
        request.parameters = @{@"formhash":formhash};
    } success:^(id responseObject, JTLoadType type) {
        NSString *messageval = [responseObject messageval];
        NSString *messagestr = [responseObject messagestr];
        if ([messageval isEqualToString:@"favorite_do_success"]) {
            success();
        } else if ([messageval isEqualToString:@"favorite_repeat"]) {
            [MBProgressHUD showInfo:messagestr];
            success();
        }else {
            [MBProgressHUD showInfo:messagestr];
        }
    } failed:^(NSError *error) {
        [MBProgressHUD showInfo:@"收藏失败"];
        if (failure) {
            failure(error);
        }
    }];
}

// 收藏帖子
+ (void)DZ_CollectionThread:(NSString *)tid success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    NSString *threadId = checkNull(tid);
    NSString *formhash = checkNull([Environment sharedEnvironment].formhash);
    if (!threadId.length) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_CollectionThread;
        request.methodType = JTMethodTypePOST;
        request.getParam = @{@"id":threadId};;
        request.parameters =  @{@"formhash":formhash};
    } success:^(id responseObject, JTLoadType type) {
        NSString *messageval = [responseObject messageval];
        NSString *messagestr = [responseObject messagestr];
        if ([messageval isEqualToString:@"favorite_do_success"]) {
            success?success():nil;
        } else {
            [MBProgressHUD showInfo:messagestr];
        }
    } failed:^(NSError *error) {
        [MBProgressHUD showInfo:@"收藏失败"];
        if (failure) {
            failure(error);
        }
    }];
}


// 取消收藏（帖子、板块）
+ (void)DZ_DeleCollection:(NSString *)fid type:(collectType)type success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    NSString *forumId = checkNull(fid);
    NSString *typeId = (type == collectForum) ? @"forum" : @"thread";
    NSString *formhash = checkNull([Environment sharedEnvironment].formhash);
    if (!forumId.length) {
        return;
    }
    
    NSDictionary *getDic = @{@"id":forumId,@"type":typeId};
    NSDictionary *postDic = @{@"deletesubmit":@"true",@"formhash":formhash};
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_unCollection;
        request.methodType = JTMethodTypePOST;
        request.getParam = getDic;
        request.parameters = postDic;
    } success:^(id responseObject, JTLoadType type) {
        NSString *messageval = [responseObject messageval];
        NSString *messagestr = [responseObject messagestr];
        if ([messageval isEqualToString:@"do_success"])
        {
            success();
        } else
        {
            [MBProgressHUD showInfo:messagestr];
        }
    } failed:^(NSError *error) {
        [MBProgressHUD showInfo:@"取消收藏失败"];
        if (failure) {
            failure(error);
        }
    }];
}

@end
