//
//  ApplyActiver.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/28.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplyActiver : NSObject

@property (nonatomic, copy) NSString *applyid;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *verified;
@property (nonatomic, copy) NSString *payment;
@property (nonatomic, strong) NSDictionary *dbufielddata;
@property (nonatomic, strong) NSMutableArray *userfield;

@end
