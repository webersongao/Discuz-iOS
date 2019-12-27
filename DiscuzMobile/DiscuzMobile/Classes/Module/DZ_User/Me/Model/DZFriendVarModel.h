//
//  DZFriendVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGlobalModel.h"

@interface DZFriendModel : NSObject

@property (nonatomic, copy) NSString *uid;  //!< 属性注释
@property (nonatomic, copy) NSString *avatar;  //!< 属性注释
@property (nonatomic, copy) NSString *username;  //!< 属性注释


@end

@interface DZFriendVarModel : DZGlobalModel

@property (nonatomic, strong) NSArray<DZFriendModel *> *list;  //!< 属性注释
@property (nonatomic, assign) NSInteger count;  //!< 属性注释



@end




