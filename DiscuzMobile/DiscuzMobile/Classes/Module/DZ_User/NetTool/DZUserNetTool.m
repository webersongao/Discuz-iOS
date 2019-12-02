//
//  DZUserNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/2.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZUserNetTool.h"
#import "DZApiRequest.h"

@implementation DZUserNetTool

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




@end
