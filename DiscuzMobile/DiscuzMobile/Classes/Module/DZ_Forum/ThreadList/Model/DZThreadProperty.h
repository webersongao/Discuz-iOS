//
//  DZThreadProperty.h
//  DiscuzMobile
//
//  Created by WebersonGao on 2019/11/28.
//  Copyright © 2019 comsenz-service.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZThreadPermModel : NSObject

@property (nonatomic, assign) NSInteger allowpost;  //!< 属性注释
@property (nonatomic, assign) NSInteger allowreply;  //!< 属性注释
@property (nonatomic, copy) NSString *uploadhash;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *allowupload;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *attachremain;  //!< 属性注释

@end

@interface DZThreadTypesModel : NSObject

@property (nonatomic, copy) NSString *status;  //!< 属性注释
@property (nonatomic, copy) NSString *required;  //!< 属性注释
@property (nonatomic, copy) NSString *listable;  //!< 属性注释
@property (nonatomic, copy) NSString *prefix;  //!< 属性注释

@property (nonatomic, strong) NSArray *types;  //!< 属性注释


@end

@interface DZActivitySetModel : NSObject

@property (nonatomic, strong) NSArray<NSString *> *activitytype;  //!< 属性注释
@property (nonatomic, strong) NSDictionary *activityfield;  //!< 属性注释

@end

