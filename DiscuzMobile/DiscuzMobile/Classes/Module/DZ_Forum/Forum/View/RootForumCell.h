//
//  RootForumCell.h
//  DiscuzMobile
//
//  Created by HB on 17/1/23.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
@class DZForumNodeModel;

@interface RootForumCell : DZBaseTableViewCell

@property (nonatomic, strong) DZForumNodeModel * node;
@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) UIButton * button;

@end
