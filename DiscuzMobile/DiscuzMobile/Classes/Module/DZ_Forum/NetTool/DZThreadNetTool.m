//
//  DZThreadNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/28.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadNetTool.h"

@implementation DZThreadNetTool

+ (void)DZ_DownloadForumListWithType:(JTLoadType)loadType para:(NSDictionary *)para isCache:(BOOL)isCache completion:(void(^)(DZThreadResModel *threadResModel,NSError *error))completion{
    
    if (!para || !completion) {
        return;
    }
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_ForumTlist;
        request.parameters = para.mutableCopy;
        request.loadType = loadType;
        request.isCache = isCache;
    } success:^(id responseObject, JTLoadType type) {
        DZThreadResModel *theadRes = [DZThreadResModel modelWithJSON:responseObject];
        completion(theadRes,DZNetError(@"", 0, @""));
    } failed:^(NSError *error) {
        completion(nil,error);
    }];
    
}





@end
