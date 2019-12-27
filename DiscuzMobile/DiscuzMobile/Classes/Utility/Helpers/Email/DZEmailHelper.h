//
//  DZEmailHelper.h
//  DiscuzMobile
//
//  Created by ZhangJitao on 2018/4/8.
//  Copyright © 2018年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZEmailHelper : NSObject

@property (nonatomic, weak) UINavigationController *navigationController;

+ (instancetype)Helper;

- (void)prepareSendEmail;


@end





