//
//  DZForumNetTool.h
//  PandaReader
//
//  Created by WebersonGao on 2018/10/25.
//

#import <Foundation/Foundation.h>
#import "DZVIPCategoryInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZForumNetTool : NSObject

+ (void)getVIPCategoryBooKInfoWithColumn:(NSString *)columntype
                                 subtype:(NSString *)subtype
                                  pageid:(NSString *)pageid
                                 success:(void(^)(DZVIPCategoryInfoModel *dataModel,NSArray * bookArray))successBlock
                                 failure:(completeBlock)failureBlock;







@end

NS_ASSUME_NONNULL_END
