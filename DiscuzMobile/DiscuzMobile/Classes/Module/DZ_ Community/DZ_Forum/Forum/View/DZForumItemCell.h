//
//  DZForumItemCell.h
//  DiscuzMobile
//
//  Created by HB on 17/5/2.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseCollectionCell.h"
@class DZBaseForumModel;

@interface DZForumItemCell : DZBaseCollectionCell

/**
 * 设置直接显示的cell数据
 */
- (void)updateItemCell:(DZBaseForumModel *)node;

@end
