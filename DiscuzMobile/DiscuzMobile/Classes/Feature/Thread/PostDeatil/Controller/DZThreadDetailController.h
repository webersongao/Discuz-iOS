//
//  DZThreadDetailController.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/14.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZBaseViewController.h"

@interface DZThreadDetailController : DZBaseViewController

@property (nonatomic, copy) NSString * tid;
@property (nonatomic, copy) NSString * forumtitle;
@property (nonatomic, assign) NSInteger currentPageId;  //!< 属性注释
@property (nonatomic, assign) BOOL isOnePage;

@property (nonatomic, copy) NSString * allowPostSpecial; // 发帖 数帖子的标记

@end
