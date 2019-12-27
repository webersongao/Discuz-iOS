//
//  DZForumBaseNode.m
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import "DZForumBaseNode.h"

@implementation DZForumBaseNode


- (NSArray *)subTreeNodeList:(NSArray<NSString *> *)forums allForum:(NSArray <DZBaseForumModel *>*)forumlist {
    
    NSMutableArray *subNodeArr = [NSMutableArray array];
    for (DZBaseForumModel *forum in forumlist) {
        for (NSString *forumId in forums) {
            if ([forumId isEqualToString:forum.fid]) {
                DZForumBaseNode *subNode = [[DZForumBaseNode alloc] init];
                subNode.fidStr = forum.fid;
                subNode.nameStr = forum.name;
                if (!forum.sublist.count) {
                    subNode.subNodeList = nil;
                }else{
                    // 最多三层，不会再多啦
                    NSMutableArray *innerSubNodeArr = [NSMutableArray array];
                    for (DZForumNodeModel *nodeModel in forum.sublist) {
                        DZForumBaseNode *innerSubNode = [[DZForumBaseNode alloc] init];
                        innerSubNode.fidStr = nodeModel.fid;
                        innerSubNode.nameStr = nodeModel.name;
                        innerSubNode.subNodeList = nil;
                        [innerSubNodeArr addObject:innerSubNode];
                    }
                    subNode.subNodeList = innerSubNodeArr;
                }
                [subNodeArr addObject:subNode];
            }
        }
    }
    
    return subNodeArr;
}

@end
