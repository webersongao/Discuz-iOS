//
//  DZGlobalTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/21.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZDiscoverModel.h"

@interface DZGlobalTool : NSObject

+(void)requestGlobalForumCategoryData:(void(^)(DZDiscoverModel *indexModel))categoryBlock;

@end


