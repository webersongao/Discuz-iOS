//
//  DZForumThreadController.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZBaseViewController.h"

typedef void(^CForumBlock)(BOOL isCollection);

@interface DZForumThreadController : DZBaseViewController

@property (nonatomic ,copy) NSString *forumFid;
@property (nonatomic, copy) CForumBlock cForumBlock;

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) UIView *contentView;
// 设置tableview滚动属性
- (void)setScrollEnable:(BOOL)scrollable;

@end
