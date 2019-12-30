//
//  DZThreadListCell.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/19.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "DZThreadListModel+Display.h"
#import "DZThreadCellView.h"

@interface DZThreadListCell : DZBaseTableViewCell

@property (nonatomic, strong) DZThreadCellView *cellView;  //!< 属性注释

@property (nonatomic, strong,readonly) DZThreadListModel *cellModel;  //!< 属性注释

-(void)configThreadCellManager;
/// @param isTop 是否 置顶帖
- (void)updateThreadCell:(DZThreadListModel *)Model isTop:(BOOL)isTop;


@end


