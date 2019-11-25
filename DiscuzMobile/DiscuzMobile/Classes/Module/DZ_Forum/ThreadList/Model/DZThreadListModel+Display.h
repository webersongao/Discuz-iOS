//
//  DZThreadListModel+Display.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/31.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZThreadListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZThreadListModel (Display)
+ (void)setThreadData:(id)responseObject andFid:(NSString *)fid andPage:(NSInteger)page handle:(void (^)(NSArray *topArr, NSArray *commonArr, NSArray *allArr, NSInteger notFourmCount))handle;

- (DZThreadListModel *)dealSpecialThread;
@end

NS_ASSUME_NONNULL_END
