//
//  DZFootMarkRootController.m
//  DiscuzMobile
//
//  Created by HB on 2017/6/12.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZFootMarkRootController.h"
#import "DZContainerController.h"
#import "DZFootForumController.h"
#import "DZFootThreadController.h"


@interface DZFootMarkRootController ()

@end

@implementation DZFootMarkRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dz_normalTitle = @"最近";
    
    DZFootForumController *forumVC = [[DZFootForumController alloc] init];
    forumVC.title =@"版块";
    
    DZFootThreadController *threadVC = [[DZFootThreadController alloc] init];
    threadVC.title = @"帖子";
    
    NSArray *ctArr = @[forumVC,threadVC];
    
    CGRect segmentRect = CGRectMake(0, 0, KScreenWidth, kToolBarHeight);
    
    DZContainerController *containerVC = [[DZContainerController alloc] init];
    [containerVC setSubControllers:ctArr parentController:self andSegmentRect:segmentRect];
}


@end








