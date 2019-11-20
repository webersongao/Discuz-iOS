//
//  BoundManageCell.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/13.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
@class HorizontalImageTextView,BoundInfoModel;

@interface BoundManageCell : DZBaseTableViewCell

@property (nonatomic, strong) HorizontalImageTextView *nameV;
@property (nonatomic, strong) UIButton *detailBtn;

- (void)setData:(BoundInfoModel *)model;

@end
