//
//  DZSubForumCell.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/22.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
@class DZForumModel;

@interface DZSubForumCell : DZBaseTableViewCell

/**
 * 设置直接显示的cell数据
 */
- (void)setInfo:(DZForumModel *)node;

@end



