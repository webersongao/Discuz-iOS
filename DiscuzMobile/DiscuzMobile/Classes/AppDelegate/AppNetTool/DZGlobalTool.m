//
//  DZGlobalTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/21.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZGlobalTool.h"
#import "DZApiRequest.h"

@implementation DZGlobalTool


+(void)requestGlobalForumCategoryData:(backArrayBlock)categoryBlock{
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Forumindex;
    } success:^(id responseObject, JTLoadType type) {
        
    } failed:^(NSError *error) {
        
    }];
}

@end
