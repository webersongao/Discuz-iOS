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

@interface DZThreadNetTool : NSObject


+ (void)DZ_DownloadForumListWithType:(JTLoadType)loadType para:(NSDictionary *)para isCache:(BOOL)isCache completion:(void(^)(DZThreadResModel *threadResModel,NSError *error))completion;


@end


