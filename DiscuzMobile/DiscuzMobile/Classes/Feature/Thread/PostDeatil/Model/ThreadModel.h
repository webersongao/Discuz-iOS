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

@property (nonatomic, copy, readonly) NSString *subject;
@property (nonatomic, copy, readonly) NSString *dateline;
@property (nonatomic, copy, readonly) NSString *author;
@property (nonatomic, copy, readonly) NSString *favorited;
@property (nonatomic, copy, readonly) NSString *shareUrl;
@property (nonatomic, copy, readonly) NSString *shareImageUrl;
@property (nonatomic, copy, readonly) NSString *isnoimage;
@property (nonatomic, copy, readonly) NSString *fid;
@property (nonatomic, copy, readonly) NSString *pid;
@property (nonatomic, assign, readonly) NSInteger ppp;
@property (nonatomic, assign, readonly) NSInteger replies;
@property (nonatomic, assign, readonly) BOOL isActivity;  // yes参加或者 no 取消活动

@property (nonatomic, copy, readonly) NSString *allowpost;             // 发帖权限
@property (nonatomic, copy, readonly) NSString *allowreply;            // 回复权限
@property (nonatomic, copy, readonly) NSString *uploadhash;


@property (nonatomic, copy) NSString *tid;
@property (nonatomic, assign) BOOL isRequest;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong, readonly) NSURL *baseUrl;
@property (nonatomic, copy, readonly) NSString *specialString;
@property (nonatomic, strong, readonly) NSData *jsonData; // 注入 html JSON
@property (nonatomic, strong, readonly) DZPostVarModel *VarPost; // set方法处理全部数据

- (void)updateModel:(DZPosResModel *)resModel res:(NSDictionary *)resDict;




@end




