//
//  DZDiscoverModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZDiscoverModel.h"

@interface DZDiscoverModel ()

@end

@implementation DZDiscoverModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"catlist" : [DZForumNodeModel class],
             @"forumlist" : [DZBaseForumModel class],
             @"visitedforums" : [DZForumNodeModel class]
    };
}

-(instancetype)formartForumNodeData{
    
    // 分类
    for (DZForumNodeModel *nodeModel in self.catlist) {
        nodeModel.nodeLevel = 0;
        nodeModel.isExpanded = (self.catlist.count >= 10) ? NO : YES;
        [nodeModel childTreeNode:self.forumlist];
    }
    // 最近访问
    for (DZForumNodeModel *nodeModel in self.visitedforums) {
        nodeModel.nodeLevel = 0;
        nodeModel.isExpanded = (self.catlist.count >= 10) ? NO : YES;
        [nodeModel childTreeNode:self.forumlist];
    }
    
    NSMutableArray *nodeArr = [[NSMutableArray alloc] initWithCapacity:3];
    // 分类
    for (DZForumNodeModel *nodeModel in self.catlist) {
        DZForumBaseNode *baseNode = [[DZForumBaseNode alloc] init];
        baseNode.fidStr = nodeModel.fid;
        baseNode.nameStr = nodeModel.name;
        baseNode.subNodeList = [baseNode subTreeNodeList:nodeModel.forums allForum:self.forumlist];
        [nodeArr addObject:baseNode];
    }
    self.indexNodeArray = nodeArr.copy;
    
    return self;
}


@end


