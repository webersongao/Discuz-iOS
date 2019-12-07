//
//  MessageListModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/9.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

//"tid": "18",
//"pid": "37",
//"subject": "第31个世界艾滋病日防艾公益健康跑鸣枪启程传染不",
//"actoruid": "10013",
//"actorusername": "123456"

@interface MessageEvarModel : NSObject

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *actoruid;
@property (nonatomic, copy) NSString *actorusername;

@end


@interface MessageListModel : NSObject

@property (nonatomic, copy) NSString *msg_id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *msg_new;
@property (nonatomic, copy) NSString *authorid;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *from_id;
@property (nonatomic, copy) NSString *from_idtype;
@property (nonatomic, copy) NSString *from_num;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, strong) MessageEvarModel *notevar;


@property (nonatomic, copy) NSString *touid;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *toavatar;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *vdateline;
@property (nonatomic, copy) NSString *tousername;



//"id": "7",
//"uid": "1",
//"type": "post",
//"new": "0",
//"authorid": "10013",
//"author": "123456",
//"note": "<a href="home.php?mod=space&uid=10013">123456</a> 回复了您的帖子 <a href="forum.php?mod=redirect&goto=findpost&ptid=18&pid=37" target="_blank">第31个世界艾滋病日防艾公益健康跑鸣枪启程传染不</a> &nbsp; <a href="forum.php?mod=redirect&goto=findpost&pid=37&ptid=18" target="_blank" class="lit">查看</a>",
//"dateline": "1574344499",
//"from_id": "18",
//"from_idtype": "post",
//"from_num": "0",
//"notevar": {
//}


@end
