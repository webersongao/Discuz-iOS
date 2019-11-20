//
//  MsglistCell.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
@class CustomMLLabel,MessageListModel;

@interface MsglistCell : DZBaseTableViewCell

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * contenLabel;
@property (nonatomic, strong) UILabel * timeLabel;

-(void)setData:(MessageListModel *)message;

- (CGFloat)cellHeight;

@end
