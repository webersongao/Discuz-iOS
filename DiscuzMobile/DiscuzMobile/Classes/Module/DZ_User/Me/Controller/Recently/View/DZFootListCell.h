//
//  DZFootListCell.h
//  DiscuzMobile
//
//  Created by HB on 17/1/16.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "BaseIconTextView.h"
#import "DZThreadListModel+Display.h"

@interface DZFootListCell : DZBaseTableViewCell

@property (nonatomic, strong) UIImageView *headV;  // 头像
@property (nonatomic, strong) UILabel *nameLab;    // 用户名
@property (nonatomic, strong) UILabel *grade;
@property (nonatomic, strong) UIImageView *tipIcon;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *desLab;     // 标题
@property (nonatomic, strong) UILabel *messageLab; // 内容
@property (nonatomic, strong) UILabel *datelineLab; // 时间

@property (nonatomic, strong) BaseIconTextView *viewsLab;   // 浏览数
@property (nonatomic, strong) BaseIconTextView *repliesLab; // 回复数
@property (nonatomic, strong) BaseIconTextView *priceLab;   // 点赞数

- (CGFloat)cellHeight;

- (void)updateFootListCell:(DZThreadListModel *)info;



@end
