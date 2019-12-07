//
//  DZLocalContext.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/15.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "EFSQLiteContext.h"
#import "DZUserModel.h"

@interface DZLocalContext : EFSQLiteContext

+ (DZLocalContext *)shared;

- (BOOL)removeLocalUser;

- (BOOL)updateLocalUser:(DZUserModel *)user;

-(DZUserModel *)GetLocalUserInfo;





@end


