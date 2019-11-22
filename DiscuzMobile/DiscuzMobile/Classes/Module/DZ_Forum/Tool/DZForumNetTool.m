//
//  DZForumNetTool.m
//  PandaReader
//
//  Created by WebersonGao on 2018/10/25.
//

#import "DZForumNetTool.h"
#import "DZGlobalTool.h"

@implementation DZForumNetTool

+ (void)getForumCategoryInfo:(BOOL)isReload forum:(void(^)(NSArray *cateList,NSArray *forumList))forumBlock{
    if ([DZMobileCtrl sharedCtrl].forumInfo.forumlist && !isReload) {
        if (forumBlock) {
            forumBlock([DZMobileCtrl sharedCtrl].forumInfo.catlist,[DZMobileCtrl sharedCtrl].forumInfo.forumlist);
        }
           return;
       }
    
    [DZGlobalTool requestGlobalForumCategoryData:^(DZForumIndexModel *indexModel) {
        [DZMobileCtrl sharedCtrl].forumInfo = indexModel;
        if (forumBlock) {
            forumBlock(indexModel.catlist,indexModel.forumlist);
        }
    }];
}





@end
