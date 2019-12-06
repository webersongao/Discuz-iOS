//
//  DZHomeNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZForumModel.h"


@interface DZHomeNetTool : NSObject


/// 拉取 热门
+(void)DZ_HomeDownLoadHotforumData:(void(^)(NSArray <DZForumModel *>*array,NSError *error))completion;

 //下载收藏版块（常去的版块）-- 登录时候
+(void)DZ_HomeDownLoadFavForumData:(void(^)(NSArray <DZForumModel *>*array,NSError *error))completion;

@end









