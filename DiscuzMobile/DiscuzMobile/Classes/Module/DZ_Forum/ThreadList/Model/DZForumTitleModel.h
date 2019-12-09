//
//  DZForumTitleModel.h
//  DiscuzMobile
//
//  Created by HB on 17/1/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DZThreadNetTool.h"

@interface DZForumTitleModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *fid;
@property (nonatomic, assign) DZ_ListType listType;  //!< 属性注释

- (instancetype)initWithName:(NSString *)name andWithFid:(NSString *)fid;

+ (instancetype)modelWithName:(NSString *)name fid:(NSString *)fid type:(DZ_ListType)type;

@end
