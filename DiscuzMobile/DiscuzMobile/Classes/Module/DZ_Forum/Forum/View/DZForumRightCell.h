//
//  DZForumRightCell.h
//  DiscuzMobile
//
//  Created by piter on 2018/1/30.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import "DZBaseTableViewCell.h"
@class DZForumModel, DZCollectButton;

typedef void(^CollectionForumBlock)(DZCollectButton *sender, DZForumModel *infoModel);

@interface DZForumRightCell : DZBaseTableViewCell

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UILabel *postsLab;
@property (nonatomic, strong) DZCollectButton *collectionBtn;

/**
 * 设置直接显示的cell数据
 */
- (void)setInfo:(DZForumModel *)node;

@property (nonatomic, copy) CollectionForumBlock collectionBlock;

@end
