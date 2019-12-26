//
//  DZLoginNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZLoginNetTool.h"
#import "DZApiRequest.h"
#import "DZUserNetTool.h"
#import "DZShareCenter.h"

@implementation DZLoginNetTool

// 用户 密码登录 或 第三方登录
+ (void)DZ_UserLginWithNameOrThirdService:(NSDictionary *)dic getData:(NSDictionary *)getData completion:(void(^)(DZLoginResModel *resModel))completion{
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Login;
        request.methodType = JTMethodTypePOST;
        request.parameters = dic;
        request.getParam = getData;
    } success:^(id responseObject, JTLoadType type) {
        DZLoginResModel *resModel = [DZLoginResModel modelWithJSON:responseObject];
        if (completion) {
            completion(resModel);
        }
    } failed:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}


// 用户 注册
+ (void)DZ_UserRegisterWithName:(NSDictionary *)postData getData:(NSDictionary *)getData completion:(void(^)(DZLoginResModel *resModel,DZBackMsgModel *msgModel))completion{
    
    NSString *registerUrl = [DZUserNetTool sharedTool].regUrl;
    if (!registerUrl.length) {
        return;
    }
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = registerUrl;
        request.parameters = postData;
        request.getParam = getData;
        request.methodType = JTMethodTypePOST;
    } success:^(id responseObject, JTLoadType type) {
        // 放弃了 reginput 参数
        NSDictionary *msgDict = [responseObject dictionaryForKey:@"Message"];
        //        NSDictionary *regDict = [[responseObject dictionaryForKey:@"Variables"] dictionaryForKey:@"reginput"];
        DZLoginResModel *resModel = [DZLoginResModel modelWithJSON:responseObject];
        //        DZRegInputModel *regVar = [DZRegInputModel modelWithJSON:regDict];
        DZBackMsgModel *msgModel = [DZBackMsgModel modelWithJSON:msgDict];
        if (completion) {
            completion(resModel,msgModel);
        }
    } failed:^(NSError *error) {
        if (completion) {
            completion(nil,nil);
        }
    }];
}


// 微信绑定
+ (void)DZ_WeixinLoginWithName:(NSString *)name passWord:(NSString *)pass  completion:(void(^)(DZLoginResModel *resModel))completion{
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSMutableDictionary *getDic = @{@"openid":[DZShareCenter shareInstance].bloginModel.openid,
                                        @"type":[DZShareCenter shareInstance].bloginModel.logintype,
                                        @"username":name,
                                        @"password":pass}.mutableCopy;
        if ([[DZShareCenter shareInstance].bloginModel.logintype isEqualToString:@"weixin"] && [DataCheck isValidString:[DZShareCenter shareInstance].bloginModel.unionid]) {
            [getDic setValue:[DZShareCenter shareInstance].bloginModel.unionid forKey:@"unionid"];
        }
        //            request.urlString = url_BindThird;
        request.parameters = getDic;
    } success:^(id responseObject, JTLoadType type) {
        DZLoginResModel *resModel = [DZLoginResModel modelWithJSON:responseObject];
        if (completion) {
            completion(resModel);
        }
    } failed:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
    
}

// 用户 重置密码
+ (void)DZ_UserResetPasswordWithPostDic:(NSDictionary *)postDic completion:(void(^)(DZBaseResModel *resModel))completion{
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.methodType = JTMethodTypePOST;
        request.urlString = DZ_Url_ResetPwd;
        request.parameters = postDic;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        if (completion) {
            completion(resModel);
        }
    } failed:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}

@end
