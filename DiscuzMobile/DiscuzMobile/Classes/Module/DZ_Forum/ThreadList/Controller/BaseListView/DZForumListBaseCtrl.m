//
//  DZForumListBaseCtrl.m
//  DiscuzMobile
//
//  Created by HB on 2017/5/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumListBaseCtrl.h"

@interface DZForumListBaseCtrl ()

@property (nonatomic, assign) BOOL isTouch;

@end

@implementation DZForumListBaseCtrl

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isTouch = YES;
}

///用于判断手指是否离开了 要做到当用户手指离开了，tableview滑到顶部，也不显示出主控制器
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.isTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) { // 子控制器到顶部 主控制器滚动 子控制器不动
        if (!self.isTouch) {
            return;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kLeaveTopNtf" object:@1];
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
    }
    
}

- (void)setCanScroll:(BOOL)canScroll {
    _canScroll = canScroll;
    if (!canScroll) {
        self.tableView.contentOffset = CGPointZero;
    }
}





@end







