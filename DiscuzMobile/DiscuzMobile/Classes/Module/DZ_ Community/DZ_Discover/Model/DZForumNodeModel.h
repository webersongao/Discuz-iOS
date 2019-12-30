//
//  DZForumNodeModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZForumModel.h"
#import "DZForumBaseNode.h"

@interface DZForumNodeModel : DZForumBaseNode

@property (nonatomic, copy) NSString *fid;  //!< 属性注释
@property (nonatomic, copy) NSString *name;  //!< 属性注释
@property (nonatomic, strong) NSArray<NSString *> *forums;  //!< 属性注释

@property (nonatomic) BOOL isExpanded;  // 展开状态 NO 开始的时候全部收起， YES 开始的时候全部展开；
@property (nonatomic) NSUInteger nodeLevel; // 级别
@property (nonatomic, strong) DZBaseForumModel *infoModel;
@property (nonatomic, strong) NSArray<DZForumNodeModel *> *childNode;


- (NSArray *)childTreeNode:(NSArray *)forumlist;

- (NSArray<DZForumNodeModel *> *)childSubTreeNode:(NSArray<DZBaseForumModel *>*)subList;

@end


