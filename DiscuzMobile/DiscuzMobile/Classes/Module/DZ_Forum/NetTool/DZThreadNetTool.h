//
//  DZThreadNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/28.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZApiRequest.h"
#import "DZThreadResModel.h"

@class DZDiscoverModel;
@interface DZThreadNetTool : NSObject

/// 板块下级，帖子列表
+ (void)DZ_DownloadForumListWithType:(JTLoadType)loadType para:(NSDictionary *)para isCache:(BOOL)isCache completion:(void(^)(DZThreadResModel *threadResModel,NSError *error))completion;

/// 板块分类列表
+ (void)DZ_DownloadForumCategoryData:(JTLoadType)loadType isCache:(BOOL)isCache completion:(void(^)(DZDiscoverModel *indexModel))completion;




@end


