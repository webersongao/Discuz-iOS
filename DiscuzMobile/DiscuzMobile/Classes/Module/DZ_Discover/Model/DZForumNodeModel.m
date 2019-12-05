//
//  DZForumNodeModel.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/22.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZForumNodeModel.h"
//#import "DZDiscoverModel.h"

@implementation DZForumNodeModel

-(void)setName:(NSString *)name{
    if ([DataCheck isValidString:name]) {
        name = [[name transformationStr] flattenHTMLTrimWhiteSpace:YES];
    }
    _name = name;
}


- (NSArray *)childTreeNode:(NSArray *)forumlist {
    
    NSMutableArray *childNodeArr = [NSMutableArray array];
    for (DZBaseForumModel *forum in forumlist) {
        if ([self.fid isEqualToString:forum.fid]) {
            self.infoModel = forum;
        }
    }
    for (NSString *childFid in self.forums) {
        for (DZBaseForumModel *forumModel in forumlist) {
            if ([forumModel.fid isEqualToString:childFid]) {
                DZForumNodeModel *childNode = [[DZForumNodeModel alloc] init];
                childNode.nodeLevel = 1;
                childNode.fid = forumModel.fid;
                childNode.name = forumModel.name;
                childNode.infoModel = forumModel;
                if (forumModel.sublist.count) {
                    NSMutableArray *subChildId = [NSMutableArray array];
                    NSArray *subChildNode = [childNode childSubTreeNode:forumModel.sublist];
                    for (DZForumNodeModel *subforum in subChildNode) {
                        [subChildId addObject:subforum.fid];
                    }
                    childNode.childNode = subChildNode;
                    childNode.forums = [subChildId copy];
                }else{
                    childNode.childNode = nil;
                    childNode.forums = nil;
                }
                [childNodeArr addObject:forumModel];
            }
        }
    }
    
    self.childNode = [childNodeArr copy];
    
    return nil;
}



- (NSArray<DZForumNodeModel *> *)childSubTreeNode:(NSArray<DZBaseForumModel *>*)subList{
    if (!subList.count) {
        return nil;
    }
    NSMutableArray *subChildNode = [NSMutableArray array];
    for (DZBaseForumModel *subforum in subList) {
        DZForumNodeModel *childNode = [[DZForumNodeModel alloc] init];
        childNode.nodeLevel = 2;
        childNode.isExpanded = NO;
        childNode.fid = subforum.fid;
        childNode.name = subforum.name;
        childNode.infoModel = subforum;
        childNode.forums = nil;
        childNode.childNode = nil;
        if (childNode.fid.length) {
            [subChildNode addObject:childNode];
        }
    }
    
    return subChildNode;
}


@end





