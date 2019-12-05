//
//  DZThreadNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/28.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZThreadNetTool.h"
#import "DZDiscoverModel.h"

@implementation DZThreadNetTool

/// 板块下级，帖子列表
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

/// 板块分类列表
+ (void)DZ_DownloadForumCategoryData:(JTLoadType)loadType isCache:(BOOL)isCache completion:(void(^)(DZDiscoverModel *indexModel))completion{
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Forumindex;
    } success:^(id responseObject, JTLoadType type) {
        DZDiscoverModel *forumDataModel = nil;
        if ([DataCheck isValidDictionary:responseObject]) {
            NSDictionary *varibles = [responseObject dictionaryForKey:@"Variables"];
            DZDiscoverModel *dataModel = [DZDiscoverModel modelWithJSON:varibles];
            forumDataModel = [dataModel formartForumNodeData];
        }
        if (completion) {
            completion(forumDataModel);
        }
    } failed:^(NSError *error) {
        if (completion) {
            completion(nil);
        }
    }];
}



@end
