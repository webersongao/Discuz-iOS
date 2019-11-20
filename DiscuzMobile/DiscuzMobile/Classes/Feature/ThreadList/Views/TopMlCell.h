//
//  TopMlCell.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/25.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "TopLabel.h"

@class ThreadListModel;

@interface TopMlCell : DZBaseTableViewCell

@property (nonatomic, strong) TopLabel *titleLabel;

- (void)setDataWithModel:(ThreadListModel *)model;

- (CGFloat)cellHeight;

@end
