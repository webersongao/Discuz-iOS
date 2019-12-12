//
//  DZSearchController.h
//  DiscuzMobile
//
//  Created by HB on 16/4/15.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, searchPostionType) {
    searchPostionTypeTabbar,
    searchPostionTypeNext,
};

@interface DZSearchController : DZBaseTableViewController
@property (nonatomic, assign) searchPostionType type;
@end
