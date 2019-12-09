//
//  DZForumTitleModel.m
//  DiscuzMobile
//
//  Created by HB on 17/1/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumTitleModel.h"

@implementation DZForumTitleModel

- (instancetype)initWithName:(NSString *)name andWithFid:(NSString *)fid type:(DZ_ListType)type{
    self = [super init];
    if (self) {
        self.name = name;
        self.fid = fid;
        self.listType = type;
    }
    return self;
}

+ (instancetype)modelWithName:(NSString *)name fid:(NSString *)fid type:(DZ_ListType)type {
    DZForumTitleModel *model = [[DZForumTitleModel alloc] initWithName:name andWithFid:fid type:type];
    return model;
}

@end
