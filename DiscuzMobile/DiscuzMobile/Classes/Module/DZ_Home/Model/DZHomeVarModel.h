//
//  DZHomeVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/7/22.
//  Copyright © 2019 comsenz-service.com.  All rights reserved.
//

#import "DZBaseVarModel.h"
#import "DZThreadListModel.h"



@interface DZHomeVarModel : DZBaseVarModel

@property (nonatomic, strong) NSArray<DZThreadListModel *> *data;

@end


