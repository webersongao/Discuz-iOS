//
//  DZNoticeModel.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZNoticeModel : NSObject

@property (nonatomic, copy) NSString *newpush;
@property (nonatomic, copy) NSString *newpm;
@property (nonatomic, copy) NSString *newprompt;
@property (nonatomic, copy) NSString *newmypost;

@end


@interface DZBackMsgModel : NSObject

// 接口操作的状态信息
//"messageval": "login_succeed",
//"messagestr": "欢迎您回来，管理员 webersongao，现在将转入登录前页面"
@property (nonatomic, copy) NSString *messageval;
@property (nonatomic, copy) NSString *messagestr;

// 是否已授权
-(BOOL)isAuthorized;

// 是否绑定成功
-(BOOL)isBindSuccess;

// 是否绑定了第三方账号
-(BOOL)isBindThird;

// 是否成功状态
-(BOOL)isSuccessed;

// 是否 登录问题为空
-(BOOL)isLoginEmpty;



@end







