//
//  DZUserNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/2.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZUserNetTool.h"
#import "DZApiRequest.h"
#import "UIImage+Limit.h"
#import "DZCheckModel.h"
@interface DZUserNetTool ()


@end

@implementation DZUserNetTool

+ (instancetype)sharedTool {
    static DZUserNetTool *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[DZUserNetTool alloc] init];
    });
    return helper;
}

- (void)DZ_CheckRegisterAPIRequest {
    [self DZ_CheckRequestSuccess:nil failure:nil];
}

- (void)DZ_CheckRegisterRequestSuccess:(void(^)(void))success failure:(void(^)(void))failure {
    [self DZ_CheckRequestSuccess:^{
        [self DZ_CheckRequestRegModelSuccess:success failure:failure];
    } failure:failure];
}

- (void)DZ_CheckRequestRegModelSuccess:(void(^)(void))success failure:(void(^)(void))failure {
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = self.regUrl;
    } success:^(id responseObject, JTLoadType type) {
        // 放弃了 reginput 参数
        NSDictionary *regDict = [[responseObject dictionaryForKey:@"Variables"] dictionaryForKey:@"reginput"];
        DZRegInputModel *regVar = [DZRegInputModel modelWithJSON:regDict];
        if (regVar) {
            self.regModel = regVar;
            success?success():nil;
        }else{
            failure?failure():nil;
        }
        success?success():nil;
    } failed:^(NSError *error) {
        failure?failure():nil;
    }];
}


- (void)DZ_CheckRequestSuccess:(void(^)(void))success failure:(void(^)(void))failure {
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_BaseCheck;
    } success:^(id responseObject, JTLoadType type) {
        DZCheckModel *model = [DZCheckModel modelWithJSON:responseObject];
        if (model.regname.length) {
            self.regUrl = [NSString stringWithFormat:@"%@&mod=%@",DZ_Url_Register,model.regname];
            [[DZMobileCtrl sharedCtrl] updateUserFormHash:model.formhash];
            success?success():nil;
        }else{
            failure?failure():nil;
        }
    } failed:^(NSError *error) {
        failure?failure():nil;
    }];
}

+ (void)DZ_UserUpdateAvatarToServer:(UIImage *)avatarImg  progress:(ProgressBlock)backProgress completion:(backBoolBlock)completion{
    
    if (!completion) {
        return;
    }
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSData *data = [avatarImg limitImageSize];
        NSString *nowTime = [[NSDate date] stringFromDateFormat:@"yyyyMMddHHmmss"];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", nowTime];
        [request addFormDataWithName:@"Filedata" fileName:fileName mimeType:@"image/png" fileData:data];
        request.urlString = DZ_Url_UploadHead;
        request.methodType = JTMethodTypeUpload;
    } progress:^(NSProgress *progress) {
        if (backProgress) {
            backProgress((1.f * progress.completedUnitCount/progress.totalUnitCount),nil);
        }
    } success:^(id responseObject, JTLoadType type) {
        id resDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([DataCheck isValidDict:resDict] && [[[resDict dictionaryForKey:@"Variables"] stringForKey:@"uploadavatar"] containsString:@"success"] ) {
            completion(YES);
        }
    } failed:^(NSError *error) {
        completion(NO);
    }];
    
}




+ (void)DZ_UserProfileFromServer:(BOOL)isMe Uid:(NSString *)uid userBlock:(void(^)(DZUserVarModel *UserVarModel, NSString *errorStr))userBlock{
    
    if (!userBlock) {
        return;
    }
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_UserInfo;
        if (isMe) {
            request.methodType = JTMethodTypePOST;
        }else{
            request.methodType = JTMethodTypeGET;
        }
        request.parameters = @{@"uid":checkNull(uid)};
    } success:^(id responseObject, JTLoadType type) {
        NSString *errorStr = nil;
        DZUserResModel *varModel = [DZUserResModel modelWithJSON:responseObject];
        if ([DataCheck isValidString:[responseObject objectForKey:@"error"]]){
            if ([[responseObject stringForKey:@"error"] isEqualToString:@"user_banned"]) {
                varModel = nil;
                errorStr = @"用户被禁止";
            }
        }else if ([varModel.Message.messagestr hasPrefix:@"请先登录后才能继续浏览"]){
            varModel = nil;
            errorStr = @"请先登录后才能继续浏览";
        }
        userBlock(varModel.Variables,errorStr);
    } failed:^(NSError *error) {
        userBlock(nil,error.localizedDescription);
    }];
    
}


// 解绑第三方账号
+ (void)DZ_UnboundThird:(NSString *)Type completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!Type.length || !completion) {
        return;
    }
    
    NSDictionary *postData = @{@"unbind":@"yes",@"type":Type,@"formhash":[DZMobileCtrl sharedCtrl].User.formhash};
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.methodType = JTMethodTypePOST;
        request.urlString = DZ_Url_UnBindThird;
        request.parameters = postData;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}

/// 好友列表
+(void)DZ_FriendListWithUid:(NSString *)uid Page:(NSInteger)Page completion:(void (^)(DZFriendVarModel *varModel, NSError *error))completion{
    
    if (/*!uid.length || */ !completion) {
        return;
    }
    
    NSDictionary *getDic = @{@"uid":checkNull(uid),@"page":checkInteger(Page)};
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_FriendList;
        request.parameters = getDic;
    } success:^(id responseObject, JTLoadType type) {
        NSDictionary *dict = [responseObject objectForKey:@"Variables"];
        DZFriendVarModel *varModel = [DZFriendVarModel modelWithJSON:dict];
        completion(varModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}

/// 我的 帖子列表 回复列表
+(void)DZ_MyThreadOrReplyListWithType:(NSString *)Type Page:(NSInteger)Page completion:(void (^)(DZMyThreadVarModel *varModel, NSError *error))completion{
    
    if (!Type.length || !completion) {
        return;
    }
    NSDictionary *dict = @{
        @"page":checkInteger(Page),
        @"type":Type
    };
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Mythread;
        request.methodType = JTMethodTypeGET;
        request.parameters = dict;
    } success:^(id responseObject, JTLoadType type) {
        NSDictionary *dict = [responseObject objectForKey:@"Variables"];
        DZMyThreadVarModel *varModel = [DZMyThreadVarModel modelWithJSON:dict];
        completion(varModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
    
}


/// 我的 收藏板块列表
+(void)DZ_FavoriteForumListWithPage:(NSInteger)Page completion:(void (^)(DZFavForumVarModel *varModel, NSError *error))completion{
    
    if (!completion) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *getDic = @{@"page":checkInteger(Page)};
        request.urlString = DZ_Url_FavoriteForum;
        request.parameters = getDic;
    } success:^(id responseObject, JTLoadType type) {
        NSDictionary *dict = [responseObject objectForKey:@"Variables"];
        DZFavForumVarModel *varModel = [DZFavForumVarModel modelWithJSON:dict];
        completion(varModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
    
}

/// 我的 收藏帖子列表
+(void)DZ_FavoriteThreadListWithPage:(NSInteger)Page completion:(void (^)(DZFavThreadVarModel *varModel, NSError *error))completion{
    
    if (!completion) {
        return;
    }
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *getDic = @{@"page":checkInteger(Page)};
        request.urlString = DZ_Url_FavoriteThread;
        request.parameters = getDic;
    } success:^(id responseObject, JTLoadType type) {
        NSDictionary *dict = [responseObject objectForKey:@"Variables"];
        DZFavThreadVarModel *varModel = [DZFavThreadVarModel modelWithJSON:dict];
        completion(varModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
    
}


/// 查询 账号绑定状态
+(void)DZ_CheckUserBindStatusWithCompletion:(void (^)(DZBindVarModel *varModel, NSError *error))completion{
    if (!completion) {
        return;
    }
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Oauths;
    } success:^(id responseObject, JTLoadType type) {
        NSDictionary *dict = [responseObject objectForKey:@"Variables"];
        DZBindVarModel *varModel = [DZBindVarModel modelWithJSON:dict];
        completion(varModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}







@end
















