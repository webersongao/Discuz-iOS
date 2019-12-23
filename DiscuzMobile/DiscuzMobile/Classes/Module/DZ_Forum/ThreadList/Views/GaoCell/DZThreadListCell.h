//
//  DZThreadListCell.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "DZThreadListModel+Display.h"

@interface DZThreadListCell : DZBaseTableViewCell

@property (nonatomic, strong) UIButton *IconButton;  //!< 头像

@property (nonatomic, strong) UIButton *zanButton;  //!< 点赞数

@property (nonatomic, strong,readonly) DZThreadListModel *cellModel;  //!< 属性注释

/// @param isTop 是否 置顶帖
- (void)updateThreadCell:(DZThreadListModel *)Model isTop:(BOOL)isTop;


@end


