//
//  DZHomeThreadListBaseCtrl.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/10.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewController.h"
#import "HomeHeader.h"

typedef NS_ENUM(NSUInteger, HomeListType) {
    HomeListBest,
    HomeListNewest,
};

@interface DZHomeThreadListBaseCtrl : DZBaseTableViewController

@property (nonatomic, assign) HomeListType listType;  //!< <#属性注释#>

@property (nonatomic, copy) void(^didScrollAction)(UIScrollView *scrollView);  //!< 属性注释

@end
