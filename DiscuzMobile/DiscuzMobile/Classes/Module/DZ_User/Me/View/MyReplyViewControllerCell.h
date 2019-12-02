//
//  MyReplyViewControllerCell.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/9/2.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import "DZBaseTableViewCell.h"

@interface MyReplyViewControllerCell : DZBaseTableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

-(void)setData:(NSDictionary*)dic;


@end
