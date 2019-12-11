//
//  DZMsgNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/11.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZMsgNetTool.h"

@implementation DZMsgNetTool


// 发送私信
+(void)DZ_PostMsgToOtherUser:(NSString *)message UserNamme:(NSString *)userName completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!completion || !message.length || !userName.length) {
        return;
    }
    
    NSDictionary * dic = @{@"formhash":[DZMobileCtrl sharedCtrl].User.formhash,
                           @"message":message,
                           @"username":userName};
    NSDictionary * getdic = @{@"touid":@"0",
                              @"pmid":@"0"};
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Sendpm;
        request.methodType = JTMethodTypePOST;
        request.parameters = dic;
        request.getParam = getdic;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}

// 发送私信 多参数
+(void)DZ_SendMsgToOtherUser:(NSString *)message UserNamme:(NSString *)userName touid:(NSString *)touid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!completion || !message.length || !userName.length || !touid.length) {
        return;
    }
    
    NSDictionary * dic = @{@"formhash":[DZMobileCtrl sharedCtrl].User.formhash,
                           @"message":message,
                           @"username":userName,
                           @"touid":touid};
    
    NSDictionary * getdic = @{@"touid":touid,
                              @"pmid":@"0"};
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.methodType = JTMethodTypePOST;
        request.urlString = DZ_Url_Sendpm;
        request.parameters = dic;
        request.getParam = getdic;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}

// 删除消息
+ (void)DZ_DeletePMMessage:(NSString *)touid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!completion || !touid.length) {
        return;
    }
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *parameters = @{@"id":touid,@"formhash":[DZMobileCtrl sharedCtrl].User.formhash};
        request.urlString = DZ_Url_DeleteMessage;
        request.methodType = JTMethodTypePOST;
        request.parameters = parameters;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
}


// 删除 单个人 消息
+ (void)DZ_DeleteOneMessage:(NSString *)touid Pid:(NSString *)Pid completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion{
    
    if (!completion || !touid.length || !Pid.length) {
        return;
    }
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        NSDictionary *parameters = @{@"id":touid,
                                     @"formhash":[DZMobileCtrl sharedCtrl].User.formhash,
                                     @"pid":Pid};
        request.urlString = DZ_Url_DeleteOneMessage;
        request.methodType = JTMethodTypePOST;
        request.parameters = parameters;
    } success:^(id responseObject, JTLoadType type) {
        DZBaseResModel *resModel = [DZBaseResModel modelWithJSON:responseObject];
        completion(resModel,nil);
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
    
}


@end




















