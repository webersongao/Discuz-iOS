//
//  DZUserNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/2.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZUserVarModel.h"
#import "DZLoginResModel.h"

@interface DZUserNetTool : NSObject

@property (nonatomic, copy) NSString *regUrl;
@property (nonatomic, strong) DZRegInputModel *regModel;

+ (instancetype)sharedTool;

// 检测注册权限
- (void)DZ_CheckRegisterAPIRequest;
- (void)DZ_CheckRequestSuccess:(void(^)(void))success failure:(void(^)(void))failure;
- (void)DZ_CheckRegisterRequestSuccess:(void(^)(void))success failure:(void(^)(void))failure;

/// 拉取用户信息
+ (void)DZ_UserProfileFromServer:(BOOL)isMe Uid:(NSString *)uid userBlock:(void(^)(DZUserVarModel *UserVarModel, NSString *errorStr))userBlock;

// 更新用户头像
+ (void)DZ_UserUpdateAvatarToServer:(UIImage *)avatarImg  progress:(ProgressBlock)progress completion:(backBoolBlock)completion;

// 解绑第三方账号
+ (void)DZ_UnboundThird:(NSString *)Type completion:(void(^)(DZBaseResModel *resModel,NSError *error))completion;




@end







