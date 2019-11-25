//
//  AppDelegate+Global.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/21.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "AppDelegate+Global.h"
#import "DZGlobalTool.h"

@implementation AppDelegate (Global)


-(void)Global_loadForumGlobalInfofromServer{
    
    [DZGlobalTool requestGlobalForumCategoryData:^(DZDiscoverModel *indexModel) {
        
        [DZMobileCtrl sharedCtrl].forumInfo = indexModel;
        
    }];
    
    
}




@end
