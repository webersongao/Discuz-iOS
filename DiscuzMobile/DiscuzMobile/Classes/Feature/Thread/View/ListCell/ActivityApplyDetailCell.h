//
//  ActivityApplyDetailCell.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/28.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"

@interface ActivityApplyDetailCell : DZBaseTableViewCell

@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UILabel *infoLab;

- (CGFloat)cellHeight;

@end
