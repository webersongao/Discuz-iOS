//
//  Environment.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/7.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZUserModel.h"
#import "DZBaseResModel.h"

@interface Environment : NSObject
//登录用户的 一些数据
@property (nonatomic, copy) NSString *member_uid;      // uid
@property (nonatomic, copy) NSString *member_username; // 用户名
@property (nonatomic, copy) NSString *formhash; // 用于提交表单时进行安全验证的值，使用方法
@property (nonatomic, copy) NSString *member_avatar;   // 头像

@property (nonatomic, copy) NSString *authKey;
@property (nonatomic, copy) NSString *auth;
@property (nonatomic, copy) NSString *saltkey;


+ (Environment *)sharedEnvironment;

@end

@interface DZRegInputModel : NSObject

//"username": "xg5D25",
//"password": "c7PP27",
//"password2": "K8kFy7",
//"email": "k5Kmg3"

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *password2;
@property (nonatomic, copy) NSString *email;


@end

@interface DZLoginResModel : DZBaseResModel

@property (nonatomic, strong) DZUserModel *Variables;  //!< 属性注释

@end
