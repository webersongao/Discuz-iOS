//
//  DZDiscoverModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseVarModel.h"
#import "DZDiscoverCateModel.h"
#import "DZBaseForumModel.h"


@interface DZDiscoverModel : DZBaseVarModel

// 板块数组
@property (nonatomic, strong) NSArray<DZBaseForumModel *> *forumlist;

// 论坛板块分类
@property (nonatomic, strong) NSArray<DZDiscoverCateModel *> *catlist;

// 论坛板块 访问足迹
@property (nonatomic, strong) NSArray<DZDiscoverCateModel *> *visitedforums;


@end


