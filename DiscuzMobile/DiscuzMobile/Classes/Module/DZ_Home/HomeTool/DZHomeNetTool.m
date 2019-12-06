//
//  DZHomeNetTool.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZHomeNetTool.h"
#import "DZApiRequest.h"

@implementation DZHomeNetTool

// 拉取 热门
+(void)DZ_HomeDownLoadHotforumData:(void(^)(NSArray <DZForumModel *>*array,NSError *error))completion {
    
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_Hotforum;
    } success:^(id responseObject, JTLoadType type) {
        NSArray *localArr = [[responseObject objectForKey:@"Variables"]objectForKey:@"data"];
        if (completion) {
            if ([DataCheck isValidArray:localArr]) {
                NSMutableArray *localModelArr = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in localArr) {
                    DZForumModel *model = [DZForumModel modelWithJSON:dict];
                    [localModelArr addObject:model];
                }
                completion(localModelArr,nil);
            }else{
                completion(nil,nil);
            }
        }
    } failed:^(NSError *error) {
        if (completion) {
            completion(nil,error);
        }
    }];
}

//下载收藏版块（常去的版块）-- 登录时候
+(void)DZ_HomeDownLoadFavForumData:(void(^)(NSArray <DZForumModel *>*array,NSError *error))completion {
    [DZApiRequest requestWithConfig:^(JTURLRequest *request) {
        request.urlString = DZ_Url_CollectionForum;
    } success:^(id responseObject, JTLoadType type) {
        DLog(@"responseObject myfacforum=====%@",responseObject);
        // 判断 list 表单是否存在   存在则存储
        NSArray *list = [[responseObject objectForKey:@"Variables"]objectForKey:@"list"];
        if (completion &&[DataCheck isValidArray:list]) {
            NSMutableArray *localModelArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in list) {
                DZForumModel *model = [DZForumModel modelWithJSON:dict];
                [localModelArr addObject:model];
            }
            completion(localModelArr,nil);
        }
    } failed:^(NSError *error) {
        if (completion) {
            completion(nil,error);
        }
    }];
}





@end
