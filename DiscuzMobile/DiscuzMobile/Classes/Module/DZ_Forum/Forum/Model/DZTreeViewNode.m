//
//  DZTreeViewNode.m
//  DiscuzMobile
//
//  Created by HB on 16/12/21.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import "DZTreeViewNode.h"
#import "DZForumModel.h"

@interface DZTreeViewNode()
@property (nonatomic, strong) NSArray *forumListArr;
@end

@implementation DZTreeViewNode

#pragma mark - 设置单一节点section
- (void)setTreeNode:(NSDictionary *)dic {
    
    self.name = [dic objectForKey:@"name"];
    self.infoModel.name = [dic objectForKey:@"name"];
    if ([dic objectForKey:@"isExpanded"]) {
        self.isExpanded = NO;
    } else {
        self.isExpanded = YES;
    }
    if ([DataCheck isValidString:[dic objectForKey:@"level"]]) { // 全部版块
        if ([[dic objectForKey:@"level"] isEqualToString:@"0"]) {
            self.nodeLevel = 0;
        } else {
            self.nodeLevel = [[dic objectForKey:@"level"] integerValue];
        }
    } else { // 热门版块
        self.infoModel = [DZForumModel modelWithJSON:dic];
        self.nodeLevel = 1;
    }
    
    self.forums = [dic objectForKey:@"forums"];
    self.forumListArr = [dic objectForKey:@"forumlist"];
    NSMutableArray *childArr = [NSMutableArray array];
    for (NSString *fid in self.forums) {
        NSDictionary *fourmInfo = [self getForumInfoWithFid:fid];
        DZTreeViewNode *treeNode1 = [[DZTreeViewNode alloc] init];
        treeNode1.nodeLevel = 1;
        treeNode1.isExpanded = NO;
        treeNode1.name = [fourmInfo objectForKey:@"name"];
        treeNode1.infoModel = [DZForumModel modelWithJSON:fourmInfo];
        [treeNode1 sublistNode:fourmInfo];
        [childArr addObject:treeNode1];
    }
    self.childNode = childArr;
}


#pragma mark - 递归获取某版块下的所有子版块row
- (void)sublistNode:(NSDictionary *)fourmInfo {
    if ([DataCheck isValidDictionary:fourmInfo]) {
        if ([DataCheck isValidArray:[fourmInfo objectForKey:@"sublist"]]) {
            NSArray *subArr = [fourmInfo objectForKey:@"sublist"];
            NSMutableArray *childArr = [NSMutableArray array];
            for (NSDictionary *info in subArr) {
                DZTreeViewNode *treeNode = [[DZTreeViewNode alloc] init];
                treeNode.nodeLevel = self.nodeLevel + 1;
                treeNode.isExpanded = NO;
                treeNode.name = [info objectForKey:@"name"];
                treeNode.infoModel = [DZForumModel modelWithJSON:info];
                [childArr addObject:treeNode];
                if ([DataCheck isValidArray:[info objectForKey:@"sublist"]]) { // 递归判断
                    [treeNode sublistNode:info];
                }
            }
            self.childNode = childArr;
        }
    }
}

- (NSDictionary *)getForumInfoWithFid:(NSString *)fid {
    for (NSDictionary *info in self.forumListArr) {
        if ([fid isEqualToString:[info objectForKey:@"fid"]]) {
            return info;
        }
    }
    return nil;
}

+ (NSArray *)setAllforumData:(id)responseObject { // 设置全部版块  有主导航
    NSMutableArray *forumArray = [NSMutableArray array];
    NSArray *catlist = [[responseObject objectForKey:@"Variables"] objectForKey:@"catlist"];
    NSArray *forumlist = [[responseObject objectForKey:@"Variables"] objectForKey:@"forumlist"];
    
    for (int i = 0; i < catlist.count; i++) {
        DZTreeViewNode * treeNode = [[DZTreeViewNode alloc] init];
        NSMutableDictionary *nodeDic = [NSMutableDictionary dictionary];
        nodeDic = [catlist[i] mutableCopy];
        [nodeDic setValue:forumlist forKey:@"forumlist"];
        [nodeDic setValue:@"0" forKey:@"level"];
        if (catlist.count >= 10) {
            [nodeDic setValue:@"NO" forKey:@"isExpanded"];
        }
        [treeNode setTreeNode:nodeDic];
        [forumArray addObject:treeNode];
    }
    
    return forumArray;
}




#pragma mark - setter、getter
-(void)setName:(NSString *)name{
    if ([DataCheck isValidString:name]) {
        name = [[name transformationStr] flattenHTMLTrimWhiteSpace:YES];
    }
    _name = name;
}


@end






