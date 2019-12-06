//
//  DZBaseAuthModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/6.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseVarModel.h"
#import "DZThreadProperty.h"

@interface DZBaseAuthModel : DZBaseVarModel

@property (nonatomic, strong) DZThreadPermModel *allowperm;  //!< 属性注释
@property (nonatomic, strong) DZForumModel *forum;  //!< 属性注释
@property (nonatomic, strong) DZThreadTypesModel *threadtypes;  //!< 属性注释
@property (nonatomic, strong) DZActivitySetModel *activity_setting;  //!< 属性注释

@end


