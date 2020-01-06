//
//  DZDiscoverNetTool.h
//  PandaReader
//
//  Created by WebersonGao on 2018/10/25.
//

#import <Foundation/Foundation.h>



@interface DZDiscoverNetTool : NSObject

+ (void)getForumCategoryInfo:(BOOL)isReload forum:(void(^)(NSArray *cateList,NSArray *forumList))forumBlock;







@end


