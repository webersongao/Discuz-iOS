//
//  DZUserNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/2.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZUserVarModel.h"

@interface DZUserNetTool : NSObject

@property (nonatomic, copy) NSString *regUrl;
@property (nonatomic, strong) NSDictionary *regKeyDic;

+ (instancetype)sharedTool;

- (void)DZ_CheckRegisterAPIRequest;

- (void)DZ_CheckRequestSuccess:(void(^)(void))success failure:(void(^)(void))failure;

- (void)DZ_CheckRegisterRequestSuccess:(void(^)(void))success failure:(void(^)(void))failure;


+ (void)DZ_UserProfileFromServer:(BOOL)isMe Uid:(NSString *)uid userBlock:(void(^)(DZUserVarModel *UserVarModel, NSString *errorStr))userBlock;

+ (void)DZ_UserUpdateAvatarToServer:(UIImage *)avatarImg  progress:(ProgressBlock)progress completion:(backBoolBlock)completion;

@end


