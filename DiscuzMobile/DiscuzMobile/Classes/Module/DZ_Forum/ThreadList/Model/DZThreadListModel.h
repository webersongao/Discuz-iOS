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


@interface DZThreadLayout : NSObject

@property (nonatomic, assign) CGRect iconFrame;  //!< 头像
@property (nonatomic, assign) CGRect nameFrame;  //!< 昵称
@property (nonatomic, assign) CGRect gradeFrame;  //!< 管理组
@property (nonatomic, assign) CGRect tagFrame;  //!< 置顶 或 精华

@property (nonatomic, assign) CGRect lineOneFrame;  //!< 分割线
@property (nonatomic, assign) CGRect titleFrame;  //!< 标题
@property (nonatomic, assign) CGRect subtitleFrame;  //!< 内容 或 最近回复
@property (nonatomic, assign) CGRect timeFrame;  //!< 时间

@property (nonatomic, assign) CGRect attachFrame;  //!< 附件总高度

@property (nonatomic, assign) CGRect lineTwoFrame;  //!< 分割线
@property (nonatomic, assign) CGRect viewFrame;  //!< 浏览
@property (nonatomic, assign) CGRect replyFrame;  //!< 回复
@property (nonatomic, assign) CGRect zanFrame;  //!< 赞
@property (nonatomic, assign) CGRect lineThreeeFrame;  //!< 分割线

@property (nonatomic, assign) CGFloat cellHeight;  //!< 总高度




- (instancetype)initWithModel:(DZThreadListModel *)Model;

@end

@interface DZThreadListModel : NSObject


//"tid": "33",
//"fid": "2",
//"typeid": "0",
//"readperm": "0",
//"price": "0",
//"author": "123456",
//"authorid": "10013",
//"subject": "第十四届21世纪亚洲金融年会",
//"dateline": "2019-11-21",
//"lastpost": "2019-11-24 13:59",
//"lastposter": "webersongao",
//"views": "3",
//"replies": "1",
//"displayorder": "0",
//"digest": "0",
//"special": "1",
//"attachment": "0",
//"recommend_add": "0",
//"replycredit": "0",
//"dbdateline": "1574344911",
//"dblastpost": "1574575148",
//"rushreply": "0",
//"reply": [1 item],
//"avatar": "http://demo.516680.com/uc_server/avatar.php?uid=10013&size=small",
//"recommend": "0"

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
@property (nonatomic, copy) NSString *recommend_add; // 点赞数
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *displayorder; // 判断是不是置顶帖子  displayorder  3，2，1 置顶 全局置顶3  分类置顶2  本版置顶1  0 正常  -1 回收站  -2 审核中  -3 审核忽略  -4草稿
@property (nonatomic, copy) NSString *special; //判断帖子类型 0普通 1投票 2商品  3悬赏 4活动 5辩论
@property (nonatomic, copy) NSString *attachment;
@property (nonatomic, copy) NSString *replycredit;  //!< 属性注释
@property (nonatomic, copy) NSString *dbdateline;  // 1 点赞过了
@property (nonatomic, copy) NSString *dblastpost;  // 1 点赞过了
@property (nonatomic, copy) NSString *rushreply;  // 1 点赞过了
@property (nonatomic, copy) NSString *recommend;  // 1 点赞过了
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, strong) NSArray<DZThreadReplyModel *> *reply;  //!< 属性注释
@property (nonatomic, strong) NSMutableArray<DZAttachModel*> *attachlist;

@property (nonatomic, copy) NSString *message; // 内容
@property (nonatomic, assign) BOOL isRecently;
@property (nonatomic, strong) NSDictionary *forumnames;


// 自定义字段，接口里面没有
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *useSubject;
@property (nonatomic, copy) NSString *grouptitle;


@property (nonatomic, strong) UIImage *tagImage;  // 精华 置顶 等标记的图片
@property (nonatomic, copy) NSString *gradenName;
@property (nonatomic, strong) NSMutableArray *imglist;
@property (nonatomic, strong) DZThreadLayout *layout;  //!< 帖子布局属性
@property (nonatomic, copy) NSAttributedString *mainTitle;  // 标题
@property (nonatomic, copy) NSString *lastReplyString;  // 最新回复
@property (nonatomic, strong) NSAttributedString *lastReply;  // 最新回复

-(void)updateThreadModelLayout;


@end
