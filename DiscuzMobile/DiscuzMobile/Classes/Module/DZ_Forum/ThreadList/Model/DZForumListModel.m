//
//  DZForumListModel.m
//  DiscuzMobile
//
//  Created by HB on 17/1/17.
//  Copyright © 2017年 comsenz-service.com.  All rights reserved.
//

#import "DZForumListModel.h"

@implementation DZForumListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithName:(NSString *)name andWithFid:(NSString *)fid {
    self = [super init];
    if (self) {
        self.name = name;
        self.fid = fid;
    }
    return self;
}

+ (instancetype)initWithName:(NSString *)name andWithFid:(NSString *)fid {
    DZForumListModel *model = [[DZForumListModel alloc] initWithName:name andWithFid:fid];
    return model;
}

@end
