//
//  PostDebateModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/6/26.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZSecVerifyView.h"

@interface PostDebateModel : NSObject

@property (nonatomic, copy) NSString *subject;     // 标题
@property (nonatomic, copy) NSString *message;     // 详细
@property (nonatomic, copy) NSString *special;     // 5 固定参数
@property (nonatomic, copy) NSString *affirmpoint; // 正方观点
@property (nonatomic, copy) NSString *negapoint;   // 反方观点
@property (nonatomic, copy) NSString *endtime;     // 结束时间
@property (nonatomic, copy) NSString *umpire;      // 裁判

@property (nonatomic, copy) NSString *typeId;     // 选择类型



- (NSDictionary *)creatDebateDictdata:(DZSecVerifyView *)verifyView;





@end
