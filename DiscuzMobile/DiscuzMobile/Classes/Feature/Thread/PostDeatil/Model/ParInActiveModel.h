//
//  ParInActiveModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/8/4.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParInActiveModel : NSObject

@property (nonatomic, copy) NSString *available;
@property (nonatomic, copy) NSString *choices;
@property (nonatomic, copy) NSString *fieldid;
@property (nonatomic, copy) NSString *formtype;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *payment;

@property (nonatomic, copy) NSString *fieldValue;
@property (nonatomic, strong) NSArray *choicesArray;

@end
