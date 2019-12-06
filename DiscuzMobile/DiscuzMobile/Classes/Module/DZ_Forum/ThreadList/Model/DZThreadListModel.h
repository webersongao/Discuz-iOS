//
//  DZThreadListModel.h
//  DiscuzMobile
//
//  Created by HB on 17/1/18.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZThreadReplyModel.h"
@class DZAttachModel;

@interface DZThreadListModel : NSObject

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *readperm;  //!< 属性注释
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *authorid;
@property (nonatomic, copy) NSString *subject; // 标题
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *lastpost;
@property (nonatomic, copy) NSString *lastposter;
@property (nonatomic, copy) NSString *views;   // 查看数
@property (nonatomic, copy) NSString *replies; // 回复数
@property (nonatomic, copy) NSString *displayorder; // 判断是不是置顶帖子  displayorder  3，2，1 置顶 全局置顶3  分类置顶2  本版置顶1  0 正常  -1 回收站  -2 审核中  -3 审核忽略  -4草稿
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *special; //判断帖子类型 0普通 1投票 2商品  3悬赏 4活动 5辩论
@property (nonatomic, copy) NSString *attachment;
@property (nonatomic, copy) NSString *recommend_add; // 点赞数
@property (nonatomic, copy) NSString *replycredit;  //!< 属性注释
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *recommend;  // 1 点赞过了
@property (nonatomic, copy) NSString *dbdateline;  // 1 点赞过了
@property (nonatomic, copy) NSString *dblastpost;  // 1 点赞过了
@property (nonatomic, copy) NSString *rushreply;  // 1 点赞过了
@property (nonatomic, strong) DZThreadReplyModel *reply;  //!< 属性注释

@property (nonatomic, copy) NSString *message; // 内容
@property (nonatomic, strong) NSMutableArray<DZAttachModel*> *attachlist;
@property (nonatomic, assign) BOOL isRecently;
@property (nonatomic, strong) NSDictionary *forumnames;


// 我自己处理过的标题，接口里面没有
@property (nonatomic, strong) NSMutableArray *imglist;
@property (nonatomic, copy) NSString *useSubject;
@property (nonatomic, copy) NSString *grouptitle;
@property (nonatomic, copy) NSString *typeName;

// 展示形式是否要依照特殊帖子的判断。
- (BOOL)isSpecialThread;
// 置顶帖判断
- (BOOL)isTopThread;

// 分类
+ (NSDictionary *)getTypeDic:(id)responseObject;
// 用户组
+ (NSDictionary *)getGroupDic:(id)responseObject;

@end
