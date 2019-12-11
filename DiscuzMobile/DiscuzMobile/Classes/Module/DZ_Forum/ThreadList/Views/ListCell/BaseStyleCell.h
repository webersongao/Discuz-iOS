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

@property (nonatomic, strong) UIImageView *headV;  // 头像
@property (nonatomic, strong) UILabel *nameLab;    // 用户名
@property (nonatomic, strong) UILabel *grade;
@property (nonatomic, strong) UIImageView *tipIcon;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *desLab;     // 标题
@property (nonatomic, strong) UILabel *messageLab; // 内容
@property (nonatomic, strong) UILabel *datelineLab; // 时间
@property (nonatomic, assign) BOOL hasPic;

@property (nonatomic, strong) BaseIconTextView *viewsLab;   // 浏览数
@property (nonatomic, strong) BaseIconTextView *repliesLab; // 回复数
@property (nonatomic, strong) BaseIconTextView *priceLab;   // 点赞数

@property (nonatomic, strong,readonly) DZThreadListModel *listInfo;

- (CGFloat)cellHeight;

- (CGFloat)caculateCellHeight:(DZThreadListModel *)info;

- (void)updateThreadCell:(DZThreadListModel *)info;

@end
