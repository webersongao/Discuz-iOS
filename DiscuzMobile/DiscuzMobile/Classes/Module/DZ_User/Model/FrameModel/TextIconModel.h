//
//  TextIconModel.h
//  DiscuzMobile
//
//  Created by HB on 17/1/19.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextIconModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *detail;

+ (instancetype)initWithText:(NSString *)text andIconName:(NSString *)iconName andDetail:(NSString *)detail;

@end
