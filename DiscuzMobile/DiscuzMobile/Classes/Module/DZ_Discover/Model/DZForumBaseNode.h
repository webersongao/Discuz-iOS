//
//  DZForumBaseNode.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/27.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBaseForumModel.h"

@interface DZForumBaseNode : NSObject

@property (nonatomic, copy) NSString *fidStr;  //!< 属性注释
@property (nonatomic, copy) NSString *nameStr;  //!< 属性注释
@property (nonatomic, strong) NSArray<DZForumBaseNode *> *subNodeList;  //!< 属性注释


- (NSArray *)subTreeNodeList:(NSArray<NSString *> *)forums allForum:(NSArray <DZBaseForumModel *>*)forumlist;





@end


