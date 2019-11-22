//
//  DZForumIndexModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseVarModel.h"
#import "DZCateListModel.h"
#import "DZBaseForumModel.h"


@interface DZForumIndexModel : DZBaseVarModel

// 板块数组
@property (nonatomic, strong) NSArray<DZBaseForumModel *> *forumlist;

// 论坛板块分类
@property (nonatomic, strong) NSArray<DZCateListModel *> *catlist;


@end


