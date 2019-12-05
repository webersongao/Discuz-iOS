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
             @"forumlist" : [DZBaseForumModel class]
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
    
    
    return self;
}


@end


