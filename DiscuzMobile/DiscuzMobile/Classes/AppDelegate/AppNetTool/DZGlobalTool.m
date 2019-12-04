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


+(void)requestGlobalForumCategoryData:(void(^)(DZDiscoverModel *indexModel))categoryBlock{
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Forumindex;
    } success:^(id responseObject, JTLoadType type) {
        DZDiscoverModel *forumDataModel = nil;
        if ([DataCheck isValidDictionary:responseObject]) {
            NSDictionary *varibles = [responseObject dictionaryForKey:@"Variables"];
            DZDiscoverModel *dataModel = [DZDiscoverModel modelWithJSON:varibles];
            forumDataModel = [dataModel formartForumNodeData];
        }
        if (categoryBlock) {
            categoryBlock(forumDataModel);
        }
    } failed:^(NSError *error) {
        if (categoryBlock) {
            categoryBlock(nil);
        }
    }];
}

@end
