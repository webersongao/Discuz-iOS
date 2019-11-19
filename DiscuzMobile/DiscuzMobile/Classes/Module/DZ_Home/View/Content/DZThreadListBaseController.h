//
//  DZThreadListBaseController.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/10.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, SThreadListType) {
    SThreadListTypeDigest,
    SThreadListTypeNewest,
};

@interface DZThreadListBaseController : DZBaseTableViewController
- (SThreadListType)listType;
@end
