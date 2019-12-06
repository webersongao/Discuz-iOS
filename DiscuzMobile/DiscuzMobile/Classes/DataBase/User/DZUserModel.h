//
//  DZUserModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/15.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "EFSQLiteObject.h"

@interface DZUserModel : EFSQLiteObject

@property (nonatomic, copy) NSString *uid;  //!< 属性注释
@property (nonatomic, copy) NSString *username;  //!< 属性注释
@property (nonatomic, copy) NSString *status;  //!< 属性注释
@property (nonatomic, copy) NSString *avatar;  //!< 属性注释
@property (nonatomic, copy) NSString *regdate;  //!< 属性注释
@property (nonatomic, copy) NSString *lastvisit;  //!< 属性注释
@property (nonatomic, copy) NSString *lastpost;  //!< 属性注释


@end

