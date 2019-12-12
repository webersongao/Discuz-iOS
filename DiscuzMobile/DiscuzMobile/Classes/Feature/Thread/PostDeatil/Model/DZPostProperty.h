//
//  DZPostProperty.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/10.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
// 示例URL // http://demo.516680.com/api/mobile/?module=viewthread&submodule=checkpost&version=5&ppp=10&tid=18#

#import <Foundation/Foundation.h>
#import "DZThreadProperty.h"
#import "DZBaseThread.h"

@interface DZPostThreadModel : DZBaseThread

//"threadtable": "forum_thread",
//"posttable": "forum_post",
//"subjectenc": "%E7%AC%AC31%E4%B8%AA%E4%B8%96%E7%95%8C%E8%89%BE%E6%BB%8B%E7%97%85%E6%97%A5%E9%98%B2%E8%89%BE%E5%85%AC%E7%9B%8A%E5%81%A5%E5%BA%B7%E8%B7%91%E9%B8%A3%E6%9E%AA%E5%90%AF%E7%A8%8B%E4%BC%A0%E6%9F%93%E4%B8%8D",
//"short_subject": "第31个世界艾滋病日防艾公益健康跑鸣枪启程传染不 ...",
//"replycredit_rule": {1 item},
//"starttime": "1574342981",
//"remaintime": "",

@property (nonatomic, copy) NSString *threadtable;  //!< 属性注释
@property (nonatomic, copy) NSString *threadtableid;  //!< 属性注释
@property (nonatomic, copy) NSString *posttable;  //!< 属性注释
@property (nonatomic, copy) NSString *allreplies;  //!< 属性注释
@property (nonatomic, copy) NSString *is_archived;  //!< 属性注释
@property (nonatomic, copy) NSString *archiveid;  //!< 属性注释
@property (nonatomic, copy) NSString *subjectenc;  //!< 属性注释
@property (nonatomic, copy) NSString *short_subject;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *replycredit_rule;  //!< 属性注释
@property (nonatomic, copy) NSString *starttime;  //!< 属性注释
@property (nonatomic, copy) NSString *remaintime;  //!< 属性注释
@property (nonatomic, copy) NSString *recommendlevel;  //!< 属性注释
@property (nonatomic, copy) NSString *heatlevel;  //!< 属性注释
@property (nonatomic, copy) NSString *relay;  //!< 属性注释
@property (nonatomic, copy) NSString *forumnames;  //!< 属性注释
@property (nonatomic, copy) NSString *ordertype;  //!< 属性注释
@property (nonatomic, copy) NSString *favorited;  //!< 属性注释
@property (nonatomic, copy) NSString *recommend;  //!< 属性注释

@end


@interface DZPostListItem : NSObject

//"dateline": "2019-11-21 21:29:41",
//"message": "<img width="600" height="323" src="http://demo.taobihu.com/uploads/default/image/20181203/1543769850170209.png" border="0" alt="" /><div align="center"><font style="color:rgb(102, 102, 102)"><font face="&amp;quot">图片由中华红丝带基金提供</font></font></div><br />",
//"dbdateline": "1574342981",
//"imagelist": [2 items],
//"groupiconid": "admin",
//"avatar": "http://demo.516680.com/uc_server/avatar.php?uid=1&size=small"

@property (nonatomic, copy) NSString *pid;  //!< 属性注释
@property (nonatomic, copy) NSString *tid;  //!< 属性注释
@property (nonatomic, copy) NSString *first;  //!< 属性注释
@property (nonatomic, copy) NSString *author;  //!< 属性注释
@property (nonatomic, copy) NSString *authorid;  //!< 属性注释
@property (nonatomic, copy) NSString *dateline;  //!< 属性注释
@property (nonatomic, copy) NSString *message;  //!< 属性注释
@property (nonatomic, copy) NSString *anonymous;  //!< 属性注释
@property (nonatomic, copy) NSString *attachment;  //!< 属性注释
@property (nonatomic, copy) NSString *status;  //!< 属性注释
@property (nonatomic, copy) NSString *replycredit;  //!< 属性注释
@property (nonatomic, copy) NSString *position;  //!< 属性注释
@property (nonatomic, copy) NSString *username;  //!< 属性注释
@property (nonatomic, copy) NSString *adminid;  //!< 属性注释
@property (nonatomic, copy) NSString *groupid;  //!< 属性注释
@property (nonatomic, copy) NSString *memberstatus;  //!< 属性注释
@property (nonatomic, copy) NSString *number;  //!< 属性注释
@property (nonatomic, copy) NSString *dbdateline;  //!< 属性注释
@property (nonatomic, copy) NSArray<NSString *> *imagelist;  //!< 属性注释
@property (nonatomic, copy) NSString *groupiconid;  //!< 属性注释
@property (nonatomic, copy) NSString *avatar;  //!< 属性注释

@end


@interface DZPostForum : NSObject
//"password": "0",
//"threadtypes": {
//"status": "1",
//"required": "0",
//"listable": "0",
//"prefix": "0",
//"types": []
//}
@property (nonatomic, copy) NSString *password;  //!< 属性注释
@property (nonatomic, strong) DZThreadTypesModel *threadtypes;  //!< 属性注释
@end

@interface DZPostPoll : NSObject

// http://demo.516680.com/api/mobile/?module=viewthread&submodule=checkpost&version=5&ppp=10&tid=18#

@property (nonatomic, copy) NSString *expirations;  //!< 属性注释
@property (nonatomic, copy) NSString *multiple;  //!< 属性注释
@property (nonatomic, copy) NSString *maxchoices;  //!< 属性注释
@property (nonatomic, copy) NSString *voterscount;  //!< 属性注释
@property (nonatomic, copy) NSString *visiblepoll;  //!< 属性注释
@property (nonatomic, copy) NSString *allowvote;  //!< 属性注释
@property (nonatomic, copy) NSString *remaintime;  //!< 属性注释

@property (nonatomic, strong) NSDictionary *polloptions;  //!< 属性注释

@end

@interface DZPostActivity : NSObject


//"starttimefrom": "2053-12-9 14:25",
//"expiration": "2023-12-14 14:25",
//"ufield": {2 items},
//"creditcost": "3 威望",
//"joinfield": {2 items},
//"userfield": {2 items},
//"extfield": null,
//"basefield": [],

//示例URL http://demo.516680.com/api/mobile/?module=viewthread&submodule=checkpost&version=5&ppp=10&tid=63#
@property (nonatomic, copy) NSString *tid;  //!< 属性注释
@property (nonatomic, copy) NSString *uid;  //!< 属性注释
@property (nonatomic, copy) NSString *aid;  //!< 属性注释
@property (nonatomic, copy) NSString *cost;  //!< 属性注释
@property (nonatomic, copy) NSString *starttimefrom;  //!< 属性注释
@property (nonatomic, copy) NSString *starttimeto;  //!< 属性注释
@property (nonatomic, copy) NSString *place;  //!< 属性注释
@property (nonatomic, copy) NSString *classType;  //!< 活动类型 class字段
@property (nonatomic, copy) NSString *gender;  //!< 0 不限性别
@property (nonatomic, copy) NSString *number;  //!< 属性注释
@property (nonatomic, copy) NSString *expiration;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *ufield;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *settings;  //!< 属性注释
@property (nonatomic, copy) NSString *credit;  //!< 属性注释
@property (nonatomic, copy) NSString *thumb;  //!< 属性注释
@property (nonatomic, copy) NSString *attachurl;  //!< 属性注释
@property (nonatomic, copy) NSString *width;  //!< 属性注释
@property (nonatomic, copy) NSString *allapplynum;  //!< 属性注释
@property (nonatomic, copy) NSString *creditcost;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *joinfield;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *userfield;  //!< 属性注释
@property (nonatomic, copy) NSString *extfield;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *basefield;  //!< 属性注释
@property (nonatomic, copy) NSString *closed;  //!< 属性注释
@property (nonatomic, copy) NSString *status;  //!< 属性注释
@property (nonatomic, copy) NSString *button;  //!< 属性注释


@end












