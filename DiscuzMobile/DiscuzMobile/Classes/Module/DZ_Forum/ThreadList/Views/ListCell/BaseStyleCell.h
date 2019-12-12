//
//  BaseStyleCell.h
//  DiscuzMobile
//
//  Created by piter on 2018/1/25.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "DZThreadListModel.h"
#import "BaseIconTextView.h"

@interface BaseStyleCell : DZBaseTableViewCell

@property (nonatomic, strong) UILabel *mainTitleLabel;     // 标题
@property (nonatomic, strong) UIImageView *headV;  // 头像

@property (nonatomic, strong,readonly) DZThreadListModel *listInfo;

- (CGFloat)cellHeight;

- (CGFloat)caculateCellHeight:(DZThreadListModel *)info;


- (void)updateThreadCell:(DZThreadListModel *)info;


@end
