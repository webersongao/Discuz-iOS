//
//  DZHomeThreadContentCtrl.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/4.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseViewController.h"

@protocol ThreadListContentDelegate <NSObject>

@optional
- (void)threadListContentView:(UIScrollView *)ScrollView scrollDidScroll:(CGFloat)offsetY;

@end


@interface DZHomeThreadContentCtrl : DZBaseViewController

@property (nonatomic, assign) CGPoint listOffSet;  //!< 属性注释
@property (nonatomic, assign) BOOL contentScrollEnabled;  //!< 属性注释
@property (nonatomic, weak) id<ThreadListContentDelegate> contentDelegate;  //!< 属性注释


@end
