//
//  DZThreadTopCell.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/25.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "DZTopTitleLabel.h"

@class DZThreadListModel;

@interface DZThreadTopCell : DZBaseTableViewCell

@property (nonatomic, strong) DZTopTitleLabel *titleLabel;

- (void)updateTopCellWithModel:(DZThreadListModel *)model;

- (CGFloat)cellHeight;

@end
