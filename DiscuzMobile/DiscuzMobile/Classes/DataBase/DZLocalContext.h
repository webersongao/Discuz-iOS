//
//  DZLocalContext.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/15.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "EFSQLiteContext.h"
#import "DZGlobalModel.h"

@interface DZLocalContext : EFSQLiteContext

+ (DZLocalContext *)shared;

- (BOOL)removeLocalGloabalInfo;

- (BOOL)updateLocalGlobal:(DZGlobalModel *)global;

-(DZGlobalModel *)GetLocalGlobalInfo;





@end


