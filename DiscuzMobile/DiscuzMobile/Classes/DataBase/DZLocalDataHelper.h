//
//  DZLocalDataHelper.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/15.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "EFSQLiteHelper.h"

@interface DZLocalDataHelper : EFSQLiteHelper

+ (DZLocalDataHelper *)sharedHelper;

@end

