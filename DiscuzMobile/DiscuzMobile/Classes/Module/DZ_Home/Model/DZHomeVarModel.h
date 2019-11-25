//
//  DZHomeVarModel.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZBaseVarModel.h"
@class DZThreadListModel;

NS_ASSUME_NONNULL_BEGIN

@interface DZHomeVarModel : DZBaseVarModel

@property (nonatomic, strong) NSArray<DZThreadListModel *> *data;

@end

NS_ASSUME_NONNULL_END