//
//  DZDiscoverSquareCell.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseCollectionCell.h"
#import "DZThreadCellView.h"

@interface DZDiscoverSquareCell : DZBaseCollectionCell

@property (nonatomic, strong) DZThreadCellView *cellView;  //!< 属性注释

@property (nonatomic, strong,readonly) DZThreadListModel *cellModel;  //!< 属性注释

/// @param isTop 是否 置顶帖
- (void)updateThreadInnerCell:(DZThreadListModel *)Model isTop:(BOOL)isTop;

@end

