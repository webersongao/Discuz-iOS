//
//  DZLoginModel.h
//  DiscuzMobile
//
//  Created by HB on 16/9/22.
//  Copyright © 2016年 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZLoginModel : NSObject

@property (nonatomic,copy) NSString *logintype;
@property (nonatomic,copy) NSString *openid;
@property (nonatomic,copy) NSString *unionid;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *gbkname;

- (instancetype)initWithLogintype:(NSString *)logintype andOpenid:(NSString *)openid andGbkname:(NSString *)gbkname andUsername:(NSString *)username;
+ (instancetype)initWithLogintype:(NSString *)logintype andOpenid:(NSString *)openid andGbkname:(NSString *)gbkname andUsername:(NSString *)username;
@end
