//
//  MessageListModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/9.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageListModel : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *authorid;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *vdateline;
@property (nonatomic, copy) NSString *tousername;
@property (nonatomic, copy) NSString *toavatar;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *from_id;
@property (nonatomic, copy) NSString *from_idtype;
@property (nonatomic, copy) NSString *from_num;
@property (nonatomic, copy) NSString *msgid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *mnew;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *touid;
@property (nonatomic, strong) NSMutableDictionary *notevar;

@end
