//
//  DZForumInfoModel.h
//  DiscuzMobile
//
//  Created by HB on 16/12/21.
//  Copyright © 2016年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZForumInfoModel : NSObject

//"fid": "2",
//"name": "默认版块",
//"threads": "3",
//"posts": "4",
//"todayposts": "0",
//"lastpost": "2019-11-19 11:02",
//"lastpost_tid": "3",
//"lastpost_subject": "测试图片",
//"lastposter": "webersongao"

//allowspecialonly = 0;
//autoclose = 0;
//favorited = 0;
//fup = 38;
//livetid = 0;
//password = 0;
//picstyle = 0;
//price = 0;
//threadcount = 0;

// 板块 公共字段
@property (nonatomic, copy) NSString *fid;  // 版块ID
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *threads;    // 主题数
@property (nonatomic, copy) NSString *posts;      // 帖子数
@property (nonatomic, copy) NSString *todayposts; // 今日

@property (nonatomic, copy) NSString *lastpost;  //!< 最后发布事件
@property (nonatomic, copy) NSString *lastposter;  //!< 最新发布用户名
@property (nonatomic, copy) NSString *lastpost_tid;  //!< 属性注释
@property (nonatomic, copy) NSString *lastpost_subject;  //!< 最新发布主题名称

// 以下字段 区分接口使用 慎用！！！
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *allowspecialonly;
@property (nonatomic, copy) NSString *autoclose;
@property (nonatomic, copy) NSString *favorited;
@property (nonatomic, copy) NSString *fup;
@property (nonatomic, copy) NSString *livetid;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *picstyle;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, assign) NSInteger price;  //!< 属性注释
@property (nonatomic, assign) NSInteger threadcount;  //!< 属性注释


@property (nonatomic, strong) NSDictionary *infoDic;
@property (nonatomic, copy) NSString *descrip;
@property (nonatomic, copy) NSString *allowpostspecial;
@property (nonatomic, copy) NSString *threadmodcount;
@property (nonatomic, copy) NSString *title;




@end
