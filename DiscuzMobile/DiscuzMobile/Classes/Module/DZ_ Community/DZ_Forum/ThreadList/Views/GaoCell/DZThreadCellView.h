//
//  DZThreadCellView.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/24.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZThreadListModel;

@interface DZThreadCellView : UIView

@property (nonatomic, strong) UIButton *IconButton;  //!< 头像

@property (nonatomic, strong) UIButton *zanButton;  //!< 点赞数


/// @param isTop 是否 置顶帖
- (void)updateThreadView:(DZThreadListModel *)Model isTop:(BOOL)isTop;


@end


