//
//  DZSearchListCell.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/7/11.
//  Copyright © 2018年 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableViewCell.h"

@class DZSearchModel;

@interface DZSearchListCell : DZBaseTableViewCell

@property (strong, nonatomic)  UILabel *contentLabel;
@property (strong, nonatomic)  UILabel *timeLabel;
@property (strong, nonatomic)  UILabel *evaluateLabel;

@property (nonatomic, strong) DZSearchModel *info;

- (CGFloat)caculateCellHeight:(DZSearchModel *)info;

@end
