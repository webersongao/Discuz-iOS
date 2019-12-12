//
//  PostTypeModel.h
//  DiscuzMobile
//
//  Created by HB on 2017/5/8.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostTypeModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) PostType type;

+ (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName type:(PostType)type;


@end
