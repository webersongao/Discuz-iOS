//
//  ChatContentCell.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/7/2.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
#import "ChatYYLabel.h"
#import "MessageModel.h"

@interface ChatContentCell : DZBaseTableViewCell
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) ChatYYLabel *messageLabel;

@property (nonatomic, strong) MessageModel *messageModel;

- (CGFloat)cellHeight;
@end
