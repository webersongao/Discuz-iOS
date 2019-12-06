//
//  DZDiscoverNetTool.m
//  PandaReader
//
//  Created by WebersonGao on 2018/10/25.
//

#import "DZDiscoverNetTool.h"
#import "DZGlobalTool.h"

@implementation DZDiscoverNetTool

+ (void)getForumCategoryInfo:(BOOL)isReload forum:(void(^)(NSArray *cateList,NSArray *forumList))forumBlock{
    if ([DZMobileCtrl sharedCtrl].forumInfo.forumlist && !isReload) {
        if (forumBlock) {
            forumBlock([DZMobileCtrl sharedCtrl].forumInfo.catlist,[DZMobileCtrl sharedCtrl].forumInfo.forumlist);
        }
           return;
       }
    
    [DZGlobalTool DZ_RequestGlobalForumCategory:^(DZDiscoverModel *indexModel) {
        [DZMobileCtrl sharedCtrl].forumInfo = indexModel;
        if (forumBlock) {
            forumBlock(indexModel.catlist,indexModel.forumlist);
        }
    }];
}


+ (void)getForumCatssegoryInfo:(BOOL)isReload forum:(void(^)(NSArray *cateList,NSArray *forumList))forumBlock{

}





@end
