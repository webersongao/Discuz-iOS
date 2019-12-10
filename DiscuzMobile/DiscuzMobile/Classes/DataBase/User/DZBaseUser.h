//
//  DZBaseUser.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DZBaseUser : NSObject

//"regdate": "1573148340",
//"avatar": "http://demo.516680.com/uc_server/avatar.php?uid=10013&size=small"

@property (nonatomic, copy) NSString *uid;  //!< 属性注释
@property (nonatomic, copy) NSString *email;  //!< 属性注释
@property (nonatomic, copy) NSString *username;  //!< 属性注释
@property (nonatomic, copy) NSString *password;  //!< 属性注释
@property (nonatomic, copy) NSString *avatar;  //!< 属性注释
@property (nonatomic, copy) NSString *status;  //!< 属性注释
@property (nonatomic, copy) NSString *emailstatus;  //!< 属性注释
@property (nonatomic, copy) NSString *avatarstatus;  //!< 属性注释
@property (nonatomic, copy) NSString *videophotostatus;  //!< 属性注释
@property (nonatomic, copy) NSString *adminid;  //!< 属性注释
@property (nonatomic, copy) NSString *groupid;  //!< 属性注释
@property (nonatomic, copy) NSString *groupexpiry;  //!< 属性注释
@property (nonatomic, copy) NSString *extgroupids;  //!< 属性注释
@property (nonatomic, copy) NSString *regdate;  //!< 属性注释 // 1573148340
@property (nonatomic, copy) NSString *credits;  //!< 属性注释
@property (nonatomic, copy) NSString *notifysound;  //!< 属性注释
@property (nonatomic, copy) NSString *timeoffset;  //!< 属性注释
@property (nonatomic, copy) NSString *newpm;  //!< 属性注释
@property (nonatomic, copy) NSString *newprompt;  //!< 属性注释
@property (nonatomic, copy) NSString *accessmasks;  //!< 属性注释
@property (nonatomic, copy) NSString *allowadmincp;  //!< 属性注释
@property (nonatomic, copy) NSString *onlyacceptfriendpm;  //!< 属性注释
@property (nonatomic, copy) NSString *conisbind;  //!< 属性注释
@property (nonatomic, copy) NSString *freeze;  //!< 属性注释




@end


