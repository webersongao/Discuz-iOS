//
//  DZVoteDayVisableCell.h
//  DiscuzMobile
//
//  Created by HB on 16/11/30.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "QCheckBox.h"

@interface DZVoteDayVisableCell : DZBaseTableViewCell

@property (nonatomic, strong) UITextField *selectNumTextField; // 最多可选
@property (nonatomic, strong) UITextField *dayNumTextField; // 计票天数

@property (nonatomic, strong)  QCheckBox *checkBox; // 投票结果是否可见
@property (nonatomic, strong)  QCheckBox *checkBox1;

@end
