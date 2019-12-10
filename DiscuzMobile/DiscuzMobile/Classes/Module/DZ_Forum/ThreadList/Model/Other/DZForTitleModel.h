//
//  DZForTitleModel.h
//  DiscuzMobile
//
//  Created by HB on 17/1/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZThreadNetTool.h"

@interface DZForTitleModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic, assign) DZ_ListType listType;  //!< 属性注释

+ (instancetype)modelName:(NSString *)name type:(DZ_ListType)type;

@end
