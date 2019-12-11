//
//  DZForumTool.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/13.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumTool.h"
#import "DZLoginModule.h"

@implementation DZForumTool


// 收藏板块
+ (void)DZ_CollectionForum:(NSString *)fid success:(void(^)(void))success failure:(void(^)(NSError *error))failure {
    
    NSString *forumId = checkNull(fid);
    NSString *formhash = checkNull([DZMobileCtrl sharedCtrl].User.formhash);
    if (!forumId.length) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_CollectionForum;
        request.methodType = JTMethodTypePOST;
        request.getParam = @{@"id":checkNull(forumId)};
        request.parameters = @{@"formhash":formhash};
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        if (resModel.Message) {
            if (resModel.Message.isFavoriteSucc) {
                success();
            } else if (resModel.Message.isFavoriteRepeat) {
                [MBProgressHUD showInfo:resModel.Message.messagestr];
                success();
            }else {
                [MBProgressHUD showInfo:resModel.Message.messagestr];
            }
        }else{
            [MBProgressHUD showInfo:@"收藏失败"];
            if (failure) {
                failure(nil);
            }
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
    NSString *formhash = checkNull([DZMobileCtrl sharedCtrl].User.formhash);
    if (!threadId.length) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_CollectionThread;
        request.methodType = JTMethodTypePOST;
        request.getParam = @{@"id":threadId};;
        request.parameters =  @{@"formhash":formhash};
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        if (resModel.Message) {
            if (resModel.Message.isFavoriteSucc) {
                success?success():nil;
            } else {
                [MBProgressHUD showInfo:resModel.Message.messagestr];
            }
        }else{
            [MBProgressHUD showInfo:@"收藏失败"];
            if (failure) {
                failure(nil);
            }
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
    NSString *formhash = checkNull([DZMobileCtrl sharedCtrl].User.formhash);
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
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        if (resModel.Message && resModel.Message.isSuccessed){
            success ? success() : nil;
        }else {
            [MBProgressHUD showInfo:resModel.Message.messagestr];
        }
    } failed:^(NSError *error) {
        [MBProgressHUD showInfo:@"取消收藏失败"];
        if (failure) {
            failure(error);
        }
    }];
}

// 赞主题
+ (void)DZ_PraiseRequestTid:(NSString *)tid successBlock:(void(^)(void))success failureBlock:(void(^)(NSError *error))failure {
    if ([DZLoginModule isLogged]) {
        
        NSDictionary * paramter=@{@"tid":tid,@"hash":checkNull([DZMobileCtrl sharedCtrl].User.formhash)};
        
        [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
            request.urlString = DZ_Url_Praise;
            request.parameters = paramter;
        } success:^(id responseObject, JTLoadType type) {
            DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
            if (resModel.Message && resModel.Message.isSuccessed) {
                success?success():nil;
            } else {
                failure?failure(nil):nil;
                [MBProgressHUD showInfo:resModel.Message.messagestr];
            }
            
        } failed:^(NSError *error) {
            failure?failure(error):nil;
        }];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:DZ_UserLogin_Notify object:nil];
    }
}

// 刷新验证码 验证问题
+ (void)DZ_DownSeccode:(NSString *)type success:(void(^)(DZSecAuthModel *authModel))success failure:(void(^)(NSError *error))failure {
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *dic = @{@"type":type};
        request.urlString = DZ_Url_SecureCode;
        request.parameters = dic;
    } success:^(id responseObject, JTLoadType type) {
        DZSecAuthModel *authModel = [DZSecAuthModel modelWithJSON:responseObject];
        [[DZMobileCtrl sharedCtrl].User updateFormHash:authModel.formhash];
        if (success) {
            success(authModel);
        }
    } failed:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}







@end














