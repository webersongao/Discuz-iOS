//
//  DZThreadListBaseCtrl.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/10.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewController.h"
#import "HomeHeader.h"

typedef NS_ENUM(NSUInteger, SThreadListType) {
    SThreadListTypeDigest,
    SThreadListTypeNewest,
};

@interface DZThreadListBaseCtrl : DZBaseTableViewController

- (SThreadListType)listType;

@property (nonatomic, copy) void(^didScrollAction)(UIScrollView *scrollView);  //!< 属性注释

@end
