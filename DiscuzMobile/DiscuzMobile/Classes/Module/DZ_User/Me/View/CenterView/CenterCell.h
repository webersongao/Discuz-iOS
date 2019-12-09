//
//  CenterCell.h
//  DiscuzMobile
//
//  Created by HB on 17/1/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
@class DZHorizontalButton,TextIconModel;

@interface CenterCell : DZBaseTableViewCell

@property (nonatomic, strong) DZHorizontalButton *nameV;
@property (nonatomic, strong) UILabel *detailLab;

- (void)setData:(TextIconModel *)model;

@end
