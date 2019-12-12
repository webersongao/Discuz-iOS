//
//  SubjectCell.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/5.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableViewCell.h"

@class DZThreeadItemModel;
@interface SubjectCell : DZBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;


-(void)updateSubjectCell:(DZThreeadItemModel *)model;


@end
