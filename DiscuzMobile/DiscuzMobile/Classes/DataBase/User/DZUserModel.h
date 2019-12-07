//
//  DZUserModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/15.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "EFSQLiteObject.h"

@interface DZUserModel : EFSQLiteObject

@property (nonatomic, copy) NSString *cookiepre;
@property (nonatomic, copy) NSString *auth;
@property (nonatomic, copy) NSString *saltkey;
@property (nonatomic, copy) NSString *member_uid;
@property (nonatomic, copy) NSString *member_username;
@property (nonatomic, copy) NSString *member_avatar;
@property (nonatomic, copy) NSString *groupid;
@property (nonatomic, copy) NSString *formhash; // 用于提交表单时进行安全验证的值，使用方法
@property (nonatomic, copy) NSString *ismoderator;
@property (nonatomic, copy) NSString *readaccess;
// 自定义值 
@property (nonatomic, copy,readonly) NSString *authKey;


@end

