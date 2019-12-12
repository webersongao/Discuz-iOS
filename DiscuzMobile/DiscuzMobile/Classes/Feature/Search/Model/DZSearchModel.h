//
//  DZSearchModel.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/12/12.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZBaseThread.h"

@interface DZSearchModel : DZBaseThread

//"realtid": "26",
//"folder": "common",
//"new": "0",
//"id": "844658",
//"forumname": "日常吹水",
//"lastposterenc": "webersongao",
//"multipage": "",
//"message"

@property (nonatomic, copy) NSString *realtid;  //!< 属性注释
@property (nonatomic, copy) NSString *folder;  //!< 属性注释
@property (nonatomic, copy) NSString *src_new;  //!< 属性注释
@property (nonatomic, copy) NSString *src_id;  //!< 属性注释
@property (nonatomic, copy) NSString *forumname;  //!< 属性注释
@property (nonatomic, copy) NSString *lastposterenc;  //!< 属性注释
@property (nonatomic, copy) NSString *multipage;  //!< 属性注释
@property (nonatomic, copy) NSString *message;  //!< 属性注释

// 自定义字段
@property (nonatomic, copy) NSString *keyword;

@end
