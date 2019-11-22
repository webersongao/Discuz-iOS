//
//  DZTreeViewNode.h
//  DiscuzMobile
//
//  Created by HB on 16/12/21.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZForumModel.h"

@interface DZTreeViewNode : NSObject

@property (nonatomic) BOOL isExpanded;  // 展开状态 NO 开始的时候全部收起， YES 开始的时候全部展开；
@property (nonatomic) NSUInteger nodeLevel; // 级别

@property (nonatomic, copy) NSString * nodeName;
@property (nonatomic, strong) NSMutableArray *fids;
@property (nonatomic, strong) DZForumModel *infoModel;

@property (nonatomic, strong) NSMutableArray *forumListArr;
@property (nonatomic, strong) NSMutableArray<DZTreeViewNode *> *nodeChildren;

- (void)setTreeNode:(NSDictionary *)dic;

+ (NSArray *)setAllforumData:(id)responseObject;

+ (NSArray *)setNodeHotData:(id)responseObject;

@end
