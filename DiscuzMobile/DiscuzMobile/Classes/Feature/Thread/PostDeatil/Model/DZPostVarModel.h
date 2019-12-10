//
//  DZPostVarModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZUserModel.h"
#import "DZBaseResModel.h"
#import "DZPostProperty.h"
#import "DZThreadProperty.h"
#import "DZGroupModel.h"
#import "DZNoticeModel.h"

@interface DZPostVarModel : DZUserModel

//"allowperm": {5 items},
//"threadtypes": {5 items},
//"activity_setting": {2 items},
//"group": {125 items},
//"forum": {2 items},
//"thread": {60 items},
//"fid": "2",
//"postlist": [2 items],
//"allowpostcomment": null,
//"comments": [],
//"commentcount": [],
//"ppp": "10",
//"setting_rewriterule": null,
//"setting_rewritestatus": "",
//"forum_threadpay": "",
//"cache_custominfo_postno": [5 items],
//"special_poll": {8 items}

@property (nonatomic, copy) NSString *fid;  //!< 属性注释
@property (nonatomic, assign) NSInteger ppp;  //!< 属性注释
@property (nonatomic, strong) DZThreadPermModel *allowperm;  //!< 属性注释
@property (nonatomic, strong) DZThreadTypesModel *threadtypes;  //!< 属性注释
@property (nonatomic, strong) DZActivitySetModel *activity_setting;  //!< 属性注释
@property (nonatomic, strong) DZGroupModel *group;
@property (nonatomic, strong) DZNoticeModel *notice;
@property (nonatomic, strong) DZPostForum *forum;  //!< 属性注释
@property (nonatomic, strong) DZPostThreadModel *thread;  //!< 属性注释
@property (nonatomic, strong) NSArray<DZPostListItem *> *postlist;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *comments;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *commentcount;  //!< 属性注释
@property (nonatomic, copy) NSString *namesetting_rewriterule;  //!< 属性注释
@property (nonatomic, copy) NSString *setting_rewritestatus;  //!< 属性注释
@property (nonatomic, copy) NSString *forum_threadpay;  //!< 属性注释
@property (nonatomic, strong) NSArray <NSString *>*cache_custominfo_postno;  //!< 属性注释
@property (nonatomic, strong) DZPostPoll *special_poll;  //!< 属性注释
@property (nonatomic, strong) DZPostActivity *special_activity;  //!< 属性注释

@end



@interface DZPosResModel : DZBaseResModel

@property (nonatomic, strong) DZPostVarModel *Variables;  //!< 属性注释

@end




