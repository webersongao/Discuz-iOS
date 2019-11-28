//
//  DZThreadVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/28.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseVarModel.h"
#import "DZThreadProperty.h"
#import "DZForumModel.h"
#import "DZThreadListModel.h"

@interface DZThreadVarModel : DZBaseVarModel


//"allowperm": {5 items},
//"forum": {18 items},
//"forum_threadlist": [10 items],
//"groupiconid": {2 items},
//"sublist": [],
//"tpp": "10",
//"page": "1",
//"reward_unit": "金钱",
//"activity_setting": {2 items},
//"threadtypes": {5 items}


@property (nonatomic, strong) DZThreadPermModel *allowperm;  //!< 属性注释
@property (nonatomic, strong) DZForumModel *forum;  //!< 属性注释
@property (nonatomic, strong) NSArray<DZThreadListModel *> *forum_threadlist;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *groupiconid;  //!< 属性注释
@property (nonatomic, strong) NSArray *sublist;  //!< 属性注释

@property (nonatomic, copy) NSString *tpp;  //!< 属性注释
@property (nonatomic, assign) NSInteger page;  //!< 属性注释
@property (nonatomic, copy) NSString *reward_unit;  //!< 属性注释

@property (nonatomic, strong) DZThreadTypesModel *threadtypes;  //!< 属性注释
@property (nonatomic, strong) DZActivitySetModel *activity_setting;  //!< 属性注释



@end


