//
//  ThreadModel.h
//  DiscuzMobile
//
//  Created by HB on 17/3/7.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZPostVarModel.h"

@interface ThreadModel : NSObject

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSURL *baseUrl;

@property (nonatomic, copy) NSString *specialString;
@property (nonatomic, strong) NSData *jsonData; // 注入 html JSON

@property (nonatomic, copy) NSString *favorited;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *shareImageUrl;
@property (nonatomic, copy) NSString *isnoimage;
@property (nonatomic, copy) NSString *fid;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, assign) NSInteger ppp;
@property (nonatomic, assign) NSInteger replies;
@property (nonatomic, assign) BOOL isActivity;  // yes参加或者 no 取消活动
@property (nonatomic, assign) BOOL isRequest;

@property (nonatomic, copy) NSString *allowpost;             // 发帖权限
@property (nonatomic, copy) NSString *allowreply;            // 回复权限
@property (nonatomic, copy) NSString *uploadhash;


@property (nonatomic, strong) DZPostVarModel *VarPost; // set方法处理全部数据

@end
