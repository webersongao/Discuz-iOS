//
//  DZSecAuthModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/9.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//  注册登录 安全验证

#import "DZGlobalModel.h"

@interface DZSecAuthModel : DZGlobalModel

@property (nonatomic, copy) NSString *sechash;  //!< sechash
@property (nonatomic, copy) NSString *seccode;  //!< 验证码
@property (nonatomic, copy) NSString *secqaa;  //!< 验证问题


@end


