//
//  DZThreadRootController.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/8.
//  Copyright © 2019年 comsenz-service.com.  All rights reserved.
//

#import "DZThreadRootController.h"
#import "DZContainerController.h"
#import "DZMySubjectController.h"
#import "MyReplyController.h"

@interface DZThreadRootController ()

@end

@implementation DZThreadRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"帖子";
    
    DZMySubjectController *subVC = [[DZMySubjectController alloc] init];
    subVC.title =@"主题";
    
    MyReplyController *repVC = [[MyReplyController alloc] init];
    repVC.title = @"回复";
    
    NSArray *ctArr = @[subVC,repVC];
    
    CGRect segmentRect = CGRectMake(0, 0, KScreenWidth, 44);
    self.view.height = KScreenHeight - KNavi_ContainStatusBar_Height;
    DZContainerController *containVc = [[DZContainerController alloc] init];
    [containVc configSubControllers:ctArr parentVC:self segmentRect:segmentRect];
}

@end
