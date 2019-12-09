//
//  DZUserModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/15.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "EFSQLiteObject.h"

@interface DZUserModel : EFSQLiteObject

@property (nonatomic, copy, readonly) NSString *cookiepre;
@property (nonatomic, copy, readonly) NSString *auth;
@property (nonatomic, copy, readonly) NSString *saltkey;
@property (nonatomic, copy, readonly) NSString *member_uid;
@property (nonatomic, copy, readonly) NSString *member_username;
@property (nonatomic, copy, readonly) NSString *member_avatar;
@property (nonatomic, copy, readonly) NSString *groupid;
@property (nonatomic, copy, readonly) NSString *formhash; // 用于提交表单时进行安全验证的值，使用方法
@property (nonatomic, copy, readonly) NSString *ismoderator;
@property (nonatomic, copy, readonly) NSString *readaccess;
// 自定义值 
@property (nonatomic, copy, readonly) NSString *authKey;


-(void)updateFormHash:(NSString *)formHash;

-(void)updateUserModel:(DZUserModel *)UserModel;

@end

