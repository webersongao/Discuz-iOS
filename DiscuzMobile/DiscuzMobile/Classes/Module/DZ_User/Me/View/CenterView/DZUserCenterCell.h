//
//  DZUserCenterCell.h
//  DiscuzMobile
//
//  Created by HB on 17/1/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "TextIconModel.h"

@class DZHorizontalButton;

@interface DZUserCenterCell : DZBaseTableViewCell

@property (nonatomic, strong) DZHorizontalButton *nameV;
@property (nonatomic, strong) UILabel *detailLab;

- (void)updateCenterCell:(TextIconModel *)model access:(BOOL)isIndicator;

@end
