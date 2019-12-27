//
//  DZBindVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGlobalModel.h"


@interface DZBindUser: NSObject

//"uid": "1",
//"openid": "",
//"status": "0",
//"session_key": "",
//"type": "weixin"

@property (nonatomic, strong) NSString *uid;  //!< 属性注释
@property (nonatomic, strong) NSString *openid;  //!< 属性注释
@property (nonatomic, strong) NSString *status;  //!< 属性注释
@property (nonatomic, strong) NSString *type;  //!< 属性注释
@property (nonatomic, strong) NSString *session_key;  //!< 属性注释

// 自定义属性
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

@end

@interface DZBindVarModel : DZGlobalModel

@property (nonatomic, strong) NSArray<DZBindUser *> *users;  //!< 属性注释

@end


