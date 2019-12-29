//
//  DataCheck.h
//  DiscuzMobile
//
//  Created by gensinimac1 on 15/5/7.
//  Copyright (c) 2015年 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCheck : NSObject

+ (BOOL) isValidString:(id)input;
+ (BOOL) isValidDict:(id)input;
+ (BOOL) isValidArray:(id)input;
+ (BOOL)arrayA:(NSArray *)arrayA isEqualArrayB:(NSArray *)arrayB;

+(NSString *)rebuiltParams:(NSDictionary *)rootDictionary url:(NSString *)requestUrl;



@end
