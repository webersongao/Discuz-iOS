//
//  DZSearchNetTool.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZApiRequest.h"
#import "DZSearchVarModel.h"


@interface DZSearchNetTool : NSObject

// 搜索
+(void)DZ_SearchForumWithKey:(NSString *)keyWord Page:(NSInteger)Page completion:(void(^)(DZSearchVarModel *varModel,NSError *error))completion;




@end


