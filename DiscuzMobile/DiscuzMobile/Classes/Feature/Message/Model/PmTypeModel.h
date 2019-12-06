//
//  PmTypeModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/7/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PmTypeModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *module;
@property (nonatomic, copy) NSString *filter;
@property (nonatomic, copy) NSString *view;
@property (nonatomic, copy) NSString *type;

- (instancetype)initWithTitle:(NSString *)title andModule:(NSString *)module anFilter:(NSString *)filter andView:(NSString *)view andType:(NSString *)type;

+ (instancetype)initWithTitle:(NSString *)title andModule:(NSString *)module anFilter:(NSString *)filter andView:(NSString *)view andType:(NSString *)type;

@end
