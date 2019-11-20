//
//  BoundInfoModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/13.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoundInfoModel : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *session_key;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@end
