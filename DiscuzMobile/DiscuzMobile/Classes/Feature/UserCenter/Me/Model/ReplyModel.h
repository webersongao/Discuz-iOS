//
//  ReplyModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/6/12.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplyModel : NSObject

@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *auther;
@property (nonatomic, copy) NSString *positions;
@property (nonatomic, copy) NSString *dateline;

@end
