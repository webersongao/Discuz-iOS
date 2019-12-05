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
    
    
    
    
    
    return self;
}


- (NSArray *)setAllforumData:(id)responseObject { // 设置全部版块  有主导航
    NSMutableArray *forumArray = [NSMutableArray array];

    for (DZForumNodeModel *nodeModel in self.catlist) {
        nodeModel.nodeLevel = 0;
        nodeModel.isExpanded = (self.catlist.count >= 10) ? NO : YES;
        [nodeModel childTreeNode:self.forumlist];
        [forumArray addObject:nodeModel];
    }
    return forumArray;
}

//#pragma mark - 递归获取某版块下的所有子版块row
//- (void)sublistNode:(NSDictionary *)fourmInfo {
//    if ([DataCheck isValidDictionary:fourmInfo]) {
//        if ([DataCheck isValidArray:[fourmInfo objectForKey:@"sublist"]]) {
//            NSArray *subArr = [fourmInfo objectForKey:@"sublist"];
//            NSMutableArray *childArr = [NSMutableArray array];
//            for (NSDictionary *info in subArr) {
//                DZTreeViewNode *treeNode = [[DZTreeViewNode alloc] init];
//                treeNode.nodeLevel = self.nodeLevel + 1;
//                treeNode.isExpanded = NO;
//                treeNode.name = [info objectForKey:@"name"];
//                treeNode.infoModel = [DZForumModel modelWithJSON:info];
//                [childArr addObject:treeNode];
//                if ([DataCheck isValidArray:[info objectForKey:@"sublist"]]) { // 递归判断
//                    [treeNode sublistNode:info];
//                }
//            }
//            self.childNode = childArr;
//        }
//    }
//}
//
//- (NSDictionary *)getForumInfoWithFid:(NSString *)fid {
//    for (NSDictionary *info in self.forumListArr) {
//        if ([fid isEqualToString:[info objectForKey:@"fid"]]) {
//            return info;
//        }
//    }
//    return nil;
//}


@end
